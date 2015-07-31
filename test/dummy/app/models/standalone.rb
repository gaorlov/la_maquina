class Standalone < ActiveRecord::Base
  include CacheMachine::SubordinateCacheObject
  updates_cache_master :self, :comm_object => ::ExplodingCacheMachineCommObject
end