module LaMaquina
  module Piston
    class CachePiston < LaMaquina::Piston::Base
      class << self
        attr_accessor :redis

        def fire!( notified_class, id, notifier_class = "" )
          update_cache notified_class, id
        end

        def cache_key(notified_class, id)

          key = redis_key notified_class, id

          cache_key = redis.get key
          # key found
          return cache_key if cache_key

          # there's no key; we can't very well rerun nil for cache_key. Let's make a new entry
          update_cache notified_class, id
        end

        protected

        def update_cache( notified_class, id)
          uuid = SecureRandom.uuid()
          key = redis_key notified_class, id
          # make a class var with a default

          cache_key = "#{key}/#{uuid}"
          redis.set key, cache_key

          cache_key
        end

        def redis_key(klass, id)
          "#{klass}/#{id}"
        end
      end
    end
  end
end