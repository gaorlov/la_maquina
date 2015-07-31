class GuestTrait < ActiveRecord::Base
  belongs_to :guest
  belongs_to :trait

  include CacheMachine::SubordinateCacheObject

  updates_cache_master :guest
  updates_cache_master :trait
end