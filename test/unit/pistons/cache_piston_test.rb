require 'test_helper'


class CachePistonTest < ActiveSupport::TestCase
    def setup
    @admin = admins(:wheel)
  end

  def test_fire_updates_cache_key
    key = LaMaquina::Piston::CachePiston.cache_key :admin, @admin.id

    sleep(1)
    LaMaquina::Piston::CachePiston.fire! :admin, @admin.id

    assert_not_equal key, LaMaquina::Piston::CachePiston.cache_key(:admin, @admin.id)
  end

  def test_cache_key_generates_new_key
    redis = LaMaquina::Piston::CachePiston.redis
    key = LaMaquina::Piston::CachePiston.send :redis_key, :admin, @admin.id

    redis.del key

    assert_not_nil LaMaquina::Piston::CachePiston.cache_key(:admin, @admin.id)
  end
end