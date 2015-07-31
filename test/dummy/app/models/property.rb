class Property < ActiveRecord::Base
  belongs_to :user, :polymorphic => true

  include CacheMachine::SubordinateCacheObject

  updates_cache_master :user, :polymorphic => true
end