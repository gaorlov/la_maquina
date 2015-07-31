module LaMaquina
  class Piston

    def self.fire!(klass = "", id = nil)
      throw "A piston has to implement 'fire!'"
    end

  end
end

# in app
class SunspotPiston < LaMaquina::Piston
  class << self
    def fire!(klass = "", id = nil)
      indexed_class.find(id).index!
    end

    # of course, we would have a dependency map here
    private

    def indexed_class(klass)
      {"professional" => Professional}[klass] or raise "can't index class #{klass}!"
    end
  end

end

class CachePiston < LaMaquina::Piston
  class << self
     attr_accessor :redis

    def fire!(klass = "", id = nil)

      updated_at = SecureRandom.uuid()
      redis_key_string = redis_key klass, id
      # make a class var with a default

      cache_key = "#{redis_key_string}/#{updated_at}"
      redis.set redis_key_string, cache_key

      cache_key
    end

    def cache_key(klass, id)

      redis_key_string = redis_key klass, id

      key = redis.get redis_key_string
      # key found
      return key if key

      # there's no key; we can't very well rerun nil for cache_key. Let's make a new entry
      touch_cache klass, id
    end

    protected

    def redis_key(klass, id)
      "#{klass}/#{id}"
    end
  end
end

# in app config/la_maquina.rb
CachePiston.redis = Redis::Namespace.new(:cache_piston, :redis => ApiFactory.redis)
LaMaquina::Ciguenal.add_piston SunspotPiston, CachePiston