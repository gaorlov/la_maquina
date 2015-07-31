# La Maquina

TODO: Write a gem description

## Installation

Add this line to your application's Gemfile:

    gem 'la_maquina'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install la_maquina

## Usage



### Pistons

Once the `Ciguenal` is called it fires the `Piston`s, the behavior of which is entirely up to you. 

So, let's say, we have a couple objects that look like:

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

  include LaMaquina::Volante
  notifies :danny_trejo
end
```
and we want to let `DannyTrejo` know when his `Machete` has been updated so that we can reindex him.

`Machete` is set up to fire on update, so we'll set up a listener Piston that looks like this:

```ruby
class SunspotPiston < LaMaquina::Piston::Base
  class << self
    def fire!(klass = "", id = nil)
      indexed_class.find(id).index!
    end

    private

    def indexed_class(klass)
      {"danny_trejo" => DannyTrejo}[klass] or raise "can't index class #{klass}!"
    end
  end
end

```
Which finds the klass, does a find on it and fires off [Sunspot](https://github.com/sunspot/sunspot#reindexing-objects) `index!` 

### Setup

The setup is pretty straightforward: you do all the setting up in `config/initializers/la_maquina.rb`. 

The 3 things you have to do are: set up the pistons(if they need configuring), install them, and configure the error_handler.
For example, if you're using the CachePiston and need to set up Redis, here's how your `la_maquina.rb` will look

```ruby
LaMaquina::Pistons::CachePiston.redis = Redis::Namespace.new(:cache_piston, redis: MyRedisInstance)
LaMaquina::Ciguenal.install MyPiston, LaMaquina::Piston::CachePiston
LaMaquina::Cinegual.error_notifier = LaMaquina::ErrorNotifier::HoneybadgerNotifier
```
#### ErrorNotifier
LaMaquina by default comes with an `ErrorNotifier::Base` that will explode in a very unhelpful manner. To override it, you need to change it in the config above and roll a new `ErrorNotifier` that responds to `notify(error, details)`. For example, if you're using Honeybadger, you can use the included `LaMaquina::ErrorNotifiers::HoneybadgerNotifier, which looks like:
```ruby
class HoneybadgerNotifier < LaMaquina::ErrorNotifier::Base
  self.notify(error = nil, details = {})
    Honeybadger.notify( :error_class => "CacheMachineError: #{error.class.name}",
                        :error_message => error.message,
                        :parameters => details
                      )
  end
end
```
If you *don't* care about your exceptions and want to ignore them, there's a notifier you can use, `SilentNotifier`, making that last line in your `config/initializers/la_maquina.rb` be
```ruby
LaMaquina::Cinegual.error_notifier = LaMaquina::ErrorNotifier::SilentNotifier
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/la_maquina/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
