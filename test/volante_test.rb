require 'test_helper'


class MasterCacheObjectTest < ActiveSupport::TestCase

 
  # def test_update_subordinate_objects_suports_explicit_class_and_class_name
  #   admin_attr = admin_traits(:wheels_something_else)
  #   admin_key  = CacheMachine::MasterCacheObject.cache_key :admin, admin_attr.user.id
  #   trait_key  = CacheMachine::MasterCacheObject.cache_key :trait, admin_attr.thing.id

  #   # sleep to prevent key clash
  #   sleep(1)

  #   admin_attr.value = "lol"
  #   admin_attr.save!

  #   assert_not_equal admin_key, CacheMachine::MasterCacheObject.cache_key(:admin, admin_attr.user.id)
  #   assert_not_equal trait_key, CacheMachine::MasterCacheObject.cache_key(:trait, admin_attr.thing.id)
  # end

  # def test_update_subordinate_object_can_update_self
  #   wheel = admins(:wheel)
  #   key   = CacheMachine::MasterCacheObject.cache_key :admin, wheel.id

  #   sleep(1)
    
  #   wheel.name = "WHEEL!"
  #   wheel.save!
    
  #   assert_not_equal key, CacheMachine::MasterCacheObject.cache_key(:admin, wheel.id)
  # end


  # def test_update_subordinate_object_supports_implict_class

  #   guest_attr = guest_traits(:gregs_something)
  #   guest_key  = CacheMachine::MasterCacheObject.cache_key :guest, guest_attr.guest.id
  #   trait_key  = CacheMachine::MasterCacheObject.cache_key :trait, guest_attr.trait.id

  #   # sleep to prevent key clash
  #   sleep(1)

  #   guest_attr.value = "who cares"
  #   guest_attr.save!

  #   assert_not_equal guest_key, CacheMachine::MasterCacheObject.cache_key(:guest, guest_attr.guest.id)
  #   assert_not_equal trait_key, CacheMachine::MasterCacheObject.cache_key(:trait, guest_attr.trait.id)
  # end

  # def test_update_subordinate_object_supports_polymorphism
  #   su_whatever = properties(:su_whatever)
  #   gregs_thing = properties(:gregs_thing)
    
  #   su_key      = CacheMachine::MasterCacheObject.cache_key :admin, su_whatever.user.id
  #   gt_key      = CacheMachine::MasterCacheObject.cache_key :guest, gregs_thing.user.id

  #   sleep(1)

  #   su_whatever.value = "blah"
  #   gregs_thing.value = "blah blah"

  #   su_whatever.save!
  #   gregs_thing.save!

  #   assert_not_equal su_key, CacheMachine::MasterCacheObject.cache_key(:admin, su_whatever.user.id)
  #   assert_not_equal gt_key, CacheMachine::MasterCacheObject.cache_key(:guest, gregs_thing.user.id)
  # end
  
  # def test_subordingate_object_creation_updates_master
  #   greg  = guests(:greg)
  #   key   = CacheMachine::MasterCacheObject.cache_key :guest, greg.id

  #   sleep(1)
    
  #   greg.guest_traits.create!(:value => "some bullshit")
    
  #   assert_not_equal key, CacheMachine::MasterCacheObject.cache_key(:guest, greg.id)
  # end

  # def test_subordingate_object_destruction_updates_master
  #   wheel       = admins(:wheel)
  #   wheel_attr  = admin_traits(:wheels_something_else)
    
  #   key         = CacheMachine::MasterCacheObject.cache_key :admin, wheel.id

  #   sleep(1)
    
  #   wheel_attr.destroy
    
  #   assert_not_equal key, CacheMachine::MasterCacheObject.cache_key(:admin, wheel.id)
  # end

  # def test_subordinate_object_can_update_through
  #   modifier  = guest_trait_modifiers(:gregs_something_modifier)
  #   key       = CacheMachine::MasterCacheObject.cache_key(:guest, modifier.guest_trait.guest.id)

  #   sleep(1)

  #   modifier.modifier = "something something darkside"
  #   modifier.save!

  #   assert_not_equal key, CacheMachine::MasterCacheObject.cache_key(:guest, modifier.guest_trait.guest.id)
  # end

  # def test_subordinate_object_can_update_through_with_explicit_target_class
  #   modifier  = admin_trait_modifiers(:wheels_something_else_modifier)
  #   admin_key = CacheMachine::MasterCacheObject.cache_key :admin, modifier.admin_trait.user.id
  #   trait_key = CacheMachine::MasterCacheObject.cache_key :trait, modifier.admin_trait.thing.id

  #   sleep(1)

  #   modifier.modifier = "something something darkside"
  #   modifier.save!

  #   assert_not_equal admin_key, CacheMachine::MasterCacheObject.cache_key(:admin, modifier.admin_trait.user.id)
  #   assert_not_equal trait_key, CacheMachine::MasterCacheObject.cache_key(:trait, modifier.admin_trait.thing.id)
  # end

  # def test_touch_cache_through_gem
  #   admin = admins(:su)
  #   admin.update_attribute(:name, "lol")

  #   assert_equal $dummy_cache_params[:subordinate_class], "admin"
  # end

  # def test_touch_cache_can_handle_comm_object_failures
  #   thing = standalones(:thing)
  #   thing.value = "something new"
  #   thing.save

  #   assert_equal $error.class, RuntimeError
  #   assert_equal $error.to_s,  "oh noes!"
  #   assert_equal $deets[:master_class], "standalone"
  # end
end