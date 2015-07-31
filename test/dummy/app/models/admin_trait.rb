class AdminTrait < ActiveRecord::Base
  belongs_to :user, :class_name => "Admin"
  belongs_to :thing, :class_name => "Trait"

  include CacheMachine::SubordinateCacheObject

  updates_cache_master :user, :class => Admin
  updates_cache_master :thing, :class_name => "Trait"
end