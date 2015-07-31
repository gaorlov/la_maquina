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
  updates :danny_trejo
end
```
and we want to let `DannyTrejo` know when his `Machete` has been updated so that we can reindex him.

`Machete` is set up to fire on update, so we'll set up a listener Piston that looks like this:

```ruby
class SunspotPiston < LaMaquina::Piston
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

The setup is pretty straightforward: you do all the setting up in `config/la_maquina.rb'. 

The 2 things you have to do are: set up the pistons(if they need configuring) and install them.
For example, if you're using the CachePiston and need to set up Redis, here's how your `la_maquina.rb` will look

LaMaquina::Pistons::CachePiston.redis = Redis::Namespace.new(:cache_piston, redis: MyRedisInstance)
LaMaquina::Ciguenal.install MyPiston, LaMaquina::Pistons::CachePiston

## Contributing

1. Fork it ( https://github.com/[my-github-username]/la_maquina/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
