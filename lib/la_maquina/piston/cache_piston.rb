module LaMaquina
  module Piston
    class CachePiston < LaMaquina::Piston::Base
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
  end
end