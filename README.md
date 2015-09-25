# La Maquina

Non-database-based arbitrary updates of associated ActiveRecord models. 

Let's say you have 2 models
```ruby
class DannyTrejo < ActiveRecord::Base
  has_many :machetes
end
```
and
```ruby
class Machete < ActiveRecord::Base
  belongs_to :danny_trejo
end
```
and you want to let `DannyTrejo` know when a `Machete` has been updated, but you don't want to use `ActiveRecord`'s `touch`, you can use this gem to execute arbitrary code when `Machete` updates.

## Example

Using the example above, let's say that when a `Machete` is added, we want its corresponding `DannyTrejo` object to be reindexed by Solr, using the Sunspot interface. With a little bit of config magic, described at the end of this document, we have this:

```ruby
class DannyTrejo < ActiveRecord::Base
  has_many :machetes

  searchable do 
    double  :machete_sharpness, multiple: true do
      machetes.map(&:sharpness)
    end
  end
end
```

```ruby
class Machete < ActiveRecord::Base
  belongs_to :danny_trejo

  include LaMaquina::Notifier
  notifies_about :danny_trejo
end
```

## Usage

There are 4 main components to this gem: 

* `notifies_about`: defines the association (eg `Machete` -> `DannyTrejo`)
* Pistons: the plugins that define the behavior (eg `DannyTrejo.find(id).solr_index!`)
* ErrorNotifier: defines what you do with the errors once they come up
* DependencyMap: define the mapping between the notifier and notified classes. *OPTIONAL*

### notifies_about options

`notifies_about target, options ` is an interface that and mirrors ActiveRecord associations.
to use it, in your `ActiveRecord::Base` model
```ruby
include LaMaquina::Notifier
```
It can either notify LaMaquina about the object itself with `notifies_about :self`, or about another association with the following options:

* `:through`: same as rails.
* `:polymorphic`: same as rails. Note: expects rails default target `_type` and targe `_id` fields to be present
* `:class_name`: takes a modulized camelcased string name of the target class
* `:class`: takes a class constant of the target class type
* `:using`: this allows you to send update messages through a ruby interface (eg [JsonApiClient](https://github.com/chingor13/json_api_client)). The interface has to respond to `notify( params = {} )`.
  The params are as follows: 
  * `:notified_class`: demodulized snake_cased name of class that is notified about (eg "danny_trejo")
  * `notified_id`: the id of thje object that's being notified about. So if `Machete`(8) belongs to `DannyTrejo`(1), it will be 1
  * `notifier_class`: demodulized snake_cased name of the notifier class (eg "machete")
  **Note:** This requires the receiving side to call `LaMaquina::Engine.notify( notifier_class, id, notified_class = "" )`, so you'll have something like 
  ```ruby
  class LaMaquinaController < ApplicationController
    def notify
      notified_class  = params[:notified_class]
      notified_id     = params[:notified_id]
      notifier_class  = params[:notifier_class]

      LaMaquina::Engine.notify! notifier_class, id, notified_class

      render json: {success: true}
    end
  end
  ```
Note: `class` and `class_name` options aren't stricly checked; they're formatted and sent through

### Pistons

A piston is a plugin that can be fired on update. 

Once a model with a `notifies_about :whatever` gets updated and a commit happens, it will fire off a call to wherever LaMaquina is installed (either locally, or on another server if you're notifying through `JsonApiClient` or similar). Once LaMaquina::Engine receives the call it will fire all of its pistons in no particualr order.

So using the example from above:
```ruby
class DannyTrejo < ActiveRecord::Base
  has_many :machetes

  searchable do 
    double  :machete_sharpness, multiple: true do
      machetes.map(&:sharpness)
    end
  end
end
```
```ruby
class Machete < ActiveRecord::Base
  belongs_to :danny_trejo

  include LaMaquina::Notifier
  notifies_about :danny_trejo
end
```
We want to set up a piston that will reindex `DannyTrejo` on `Machete` update. 


```ruby
class SunspotPiston < LaMaquina::Piston::Base
  class << self
    def fire!( notified_class, id, notifier_class = "" )
      indexed_class(notified_class).find(id).solr_index!
    end

    private

    def indexed_class(klass)
      {"danny_trejo" => DannyTrejo}[klass] or raise "can't index class #{klass}!"
    end
  end
end

```
All it needs to do is respond ot `fire!( notified_class, id, notifier_class = "" )` and what happend from there is entirely up to you.


The piston above doesn't use `notifier_class`, but that comes in quite handy should you want to do complex manipulations.For example, if you have a model that has several associations that respond to `complex_code` and you want to cache that code under a composite cache key of "#{top_object}/#{association}:#{id}", you can do something like:

```ruby
class CompositeCachePison < LaMaquina::Piston::Base
  class << self
    class_attribute :redis, :map

    def fire!( notified_class, id, notifier_class )
      key = "#{notified_class}/#{notifier_class}:#{id}"

      klass = map.find notified_class
      object = klass.find(id)

      # because notifier_class is already snaked we can just send it as an association
      result = object.send(notifier_class).complex_code

      redis.set key, result
    end

    # explained below
    self.map = LaMaquina::DependencyMap::ConstantMap.new
  end
```

### DependencyMap

`DependencyMap` is a way to abstract away the dependency structure from the gem and the piston (like you have in the first piston example). 

The interface looks like 

```ruby
class Map < LaMaquina::DependencyMap::Base
  # defined in Base
  # initialize( yaml_path = nil)

  def find(*args)
    # your code here
  end

  # also defined in Base
  # attr_accessor :map
end
```
LaMaquina comes with 2 default maps: `ConstantMap` and `YamlMap`.

`LaMaquina::DependencyMap::ConstantMap` takes a string and tries to constantize it. It's not strictly speaking a map, but it works as you would expect: 
```ruby
map = LaMaquina::DependencyMap::ConstantMap.new
map.find "danny_trejo" # => DannyTrejo(id: integer, ...)
```
`LaMaquina::DependencyMap::YamlMap` get initialized with a yaml path, parses the yaml and spits out a dependency at any depth, meaning:
```yml
# map.yml
danny_trejo:
  machete: 
    1: favorite
    2: dull
```
```ruby
map = LaMaquina::DependencyMap::YamlMap.new "#{Rail.root}/config/map.yml"
map.find "danny_trejo", "machete", 1 # => "favorite"
```

### ErrorNotifier
LaMaquina by default comes with an `ErrorNotifier::Base` that will explode in a very unhelpful manner. To override it, you need to change it in the config above and roll a new `ErrorNotifier` that responds to `notify(error, details)`. For example, a really handy debugging notifier you can build is a PutsNotifier, that just puts the error details, and looks like this:
```ruby
class PutsNotifier < LaMaquina::ErrorNotifier::Base

  def self.notify(error, details)
    puts error.inspect, details.inspect
  end
end
```
If you *don't* care about your exceptions and want to ignore them, there's a notifier you can use, `SilentNotifier`, making that last line in your `config/initializers/la_maquina.rb` be
```ruby
LaMaquina.error_notifier = LaMaquina::ErrorNotifier::SilentNotifier
```

## Setup

The setup is pretty straightforward: you do all the setting up in `config/initializers/la_maquina.rb`. 

The things you have to do are: set up the pistons(if they need configuring), install them, and configure the error_handler.
For example, if you're using the CompositeCachePison and need to set up Redis, here's how your `la_maquina.rb` will look

```ruby
CompositeCachePison.redis = Redis::Namespace.new(:cache_piston, redis: Redis.new)
# you would initialize the map here, not in the piston
CompositeCachePison.map = LaMaquina::DependencyMap::ConstantMap.new

LaMaquina::Engine.install CompositeCachePison

LaMaquina.error_notifier = LaMaquina::ErrorNotifier::HoneybadgerNotifier
```


## Installation

Add this line to your application's Gemfile:

    gem 'la_maquina'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install la_maquina


## Testing

As of today, the tests rely on solr (I need to get rid of that, I know), so to test you need to

    $ cd la_maquina/test/dummy
    $ bundle install
    $ rake db:migrate RAILS_ENV=test
    $ bundle exec rake sunspot:solr:start RAILS_ENV=test
    $ bundle exec rake sunspot:reindex RAILS_ENV=test
    
    $ cd ../../
    $ rake

## Contributing

1. Fork it ( https://github.com/[my-github-username]/la_maquina/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
