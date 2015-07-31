class GuestTraitModifier < ActiveRecord::Base
  belongs_to :guest_trait

  include CacheMachine::SubordinateCacheObject

  updates_cache_master :guest, :through => :guest_trait
end