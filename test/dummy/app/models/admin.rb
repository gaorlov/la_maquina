class Admin < ActiveRecord::Base
  has_many :admin_traits
  has_many :traits, :through => :admin_traits

  has_many :properties, :as => :user

  include CacheMachine::SubordinateCacheObject
  updates_cache_master :self

  updates_cache_master :self, :comm_object => ::DummyCacheMachineCommObject
end