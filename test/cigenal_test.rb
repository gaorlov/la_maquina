require 'test_helper'

class CiguenalTest < ActiveSupport::TestCase
  
  def setup
    @admin = admins(:wheel)
  end

  def test_touch_cache_updates_cache_key
    key = LaMaquina::Ciguenal.cache_key :admin, @admin.id

    sleep(1)
    LaMaquina::Ciguenal.touch_cache :admin, @admin.id

    assert_not_equal key, LaMaquina::Ciguenal.cache_key(:admin, @admin.id)
  end

  def test_cache_key_generates_new_key
    Redis.current.del LaMaquina::Ciguenal.redis_key(:admin, @admin.id)

    assert_not_nil LaMaquina::Ciguenal.cache_key(:admin, @admin.id)
  end
end