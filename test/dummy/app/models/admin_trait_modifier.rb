class AdminTraitModifier < ActiveRecord::Base
  belongs_to :admin_trait

  include CacheMachine::SubordinateCacheObject

  updates_cache_master :user, :through => :admin_trait, :class_name => "Admin"
  updates_cache_master :thing, :through => :admin_trait, :class => Trait
end