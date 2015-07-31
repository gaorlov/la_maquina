require 'test_helper'

class MasterCacheObjectTest < ActiveSupport::TestCase
  
  def setup
    @admin = admins(:wheel)
  end

  def test_touch_cache_updates_cache_key
    key = CacheMachine::MasterCacheObject.cache_key :admin, @admin.id

    sleep(1)
    CacheMachine::MasterCacheObject.touch_cache :admin, @admin.id

    assert_not_equal key, CacheMachine::MasterCacheObject.cache_key(:admin, @admin.id)
  end

  def test_cache_key_generates_new_key
    Redis.current.del CacheMachine::MasterCacheObject.redis_key(:admin, @admin.id)

    assert_not_nil CacheMachine::MasterCacheObject.cache_key(:admin, @admin.id)
  end
end