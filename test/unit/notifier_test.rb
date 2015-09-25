require 'test_helper'


class NotifierTest < ActiveSupport::TestCase

  def setup
    keys = LaMaquina::Piston::CachePiston.redis.keys "*"
    Redis.current.del keys
  end
 
  def test_notifier_suports_explicit_class_and_class_name
    admin_attr = admin_traits(:wheels_something_else)
    admin_key  = LaMaquina::Piston::CachePiston.cache_key :admin, admin_attr.user.id
    trait_key  = LaMaquina::Piston::CachePiston.cache_key :trait, admin_attr.blah.id

    admin_attr.value = "lol"
    admin_attr.save!

    assert_not_equal admin_key, LaMaquina::Piston::CachePiston.cache_key(:admin, admin_attr.user.id)
    assert_not_equal trait_key, LaMaquina::Piston::CachePiston.cache_key(:trait, admin_attr.blah.id)
  end

  def test_notifier_can_update_self
    wheel = admins(:wheel)
    key   = LaMaquina::Piston::CachePiston.cache_key :admin, wheel.id
    
    wheel.name = "WHEEL!"
    wheel.save!
    
    assert_not_equal key, LaMaquina::Piston::CachePiston.cache_key(:admin, wheel.id)
  end


  def test_notifier_supports_implict_class

    guest_attr = guest_traits(:gregs_something)
    guest_key  = LaMaquina::Piston::CachePiston.cache_key :guest, guest_attr.guest.id
    trait_key  = LaMaquina::Piston::CachePiston.cache_key :trait, guest_attr.trait.id

    guest_attr.value = "who cares"
    guest_attr.save!

    assert_not_equal guest_key, LaMaquina::Piston::CachePiston.cache_key(:guest, guest_attr.guest.id)
    assert_not_equal trait_key, LaMaquina::Piston::CachePiston.cache_key(:trait, guest_attr.trait.id)
  end

  def test_notifier_supports_polymorphism
    su_whatever = properties(:su_whatever)
    gregs_thing = properties(:gregs_thing)
    
    su_key      = LaMaquina::Piston::CachePiston.cache_key :admin, su_whatever.user.id
    gt_key      = LaMaquina::Piston::CachePiston.cache_key :guest, gregs_thing.user.id

    su_whatever.value = "blah"
    gregs_thing.value = "blah blah"

    su_whatever.save!
    gregs_thing.save!

    assert_not_equal su_key, LaMaquina::Piston::CachePiston.cache_key(:admin, su_whatever.user.id)
    assert_not_equal gt_key, LaMaquina::Piston::CachePiston.cache_key(:guest, gregs_thing.user.id)
  end
  
  def test_object_creation_notifies_listener
    greg  = guests(:greg)
    key   = LaMaquina::Piston::CachePiston.cache_key :guest, greg.id
    
    greg.guest_traits.create!(:value => "some bullshit")
    
    assert_not_equal key, LaMaquina::Piston::CachePiston.cache_key(:guest, greg.id)
  end

  def test_object_destruction_notifies_listener
    wheel       = admins(:wheel)
    wheel_attr  = admin_traits(:wheels_something_else)
    
    key         = LaMaquina::Piston::CachePiston.cache_key :admin, wheel.id
    
    wheel_attr.destroy
    
    assert_not_equal key, LaMaquina::Piston::CachePiston.cache_key(:admin, wheel.id)
  end

  def test_notifications_can_use_through_associations
    modifier  = guest_trait_modifiers(:gregs_something_modifier)
    key       = LaMaquina::Piston::CachePiston.cache_key(:guest, modifier.guest_trait.guest.id)

    modifier.modifier = "something something darkside"
    modifier.save!

    assert_not_equal key, LaMaquina::Piston::CachePiston.cache_key(:guest, modifier.guest_trait.guest.id)
  end

  def test_notifier_can_update_through_with_explicit_target_class
    modifier  = admin_trait_modifiers(:wheels_something_else_modifier)
    admin_key = LaMaquina::Piston::CachePiston.cache_key :admin, modifier.admin_trait.user.id
    trait_key = LaMaquina::Piston::CachePiston.cache_key :trait, modifier.admin_trait.blah.id

    modifier.modifier = "something something darkside"
    modifier.save!

    assert_not_equal admin_key, LaMaquina::Piston::CachePiston.cache_key(:admin, modifier.admin_trait.user.id)
    assert_not_equal trait_key, LaMaquina::Piston::CachePiston.cache_key(:trait, modifier.admin_trait.blah.id)
  end

  def test_notify_through_intermediate_object
    admin = admins(:su)
    admin.update_attribute(:name, "lol")

    assert $dummy_params, "comm_object wasn't called"
    
    # NOTE: this value is the last notifies_about with a `using: DummyCommObject` in the file because DummyCommObject is indeed a dummy. 
    assert_equal "admin", $dummy_params[:notified_class]
  end

  def test_notifier_can_handle_comm_object_failures
    thing = standalones(:thing)
    thing.value = "something new"
    thing.save

    assert_equal RuntimeError, $error.class
    assert_equal "oh noes!", $error.to_s
    assert_equal "standalone", $deets[:notified_class]
  end

  def test_notifier_can_update_has_one
    greg  = guests(:greg)
    
    key   = LaMaquina::Piston::CachePiston.cache_key :guest_thing, greg.guest_thing.id
    
    greg.touch
    
    assert_not_equal key, LaMaquina::Piston::CachePiston.cache_key(:guest_thing, greg.guest_thing.id)
  end

  def test_notifier_can_update_has_one_through
    greg  = guests(:greg)
    
    key   = LaMaquina::Piston::CachePiston.cache_key :thing, greg.thing.id
    
    greg.touch
    
    assert_not_equal key, LaMaquina::Piston::CachePiston.cache_key(:thing, greg.thing.id)
  end

  def test_notifier_can_update_has_one_with_comm_object
    su  = admins(:su)
    
    key = LaMaquina::Piston::CachePiston.cache_key :admin_thing, su.admin_thing.id
    
    su.touch
    
    assert_not_equal key, LaMaquina::Piston::CachePiston.cache_key(:admin_thing, su.admin_thing.id)
  end

  def test_notifier_can_update_has_one_through_with_comm_object
    su  = admins(:su)
    
    key = LaMaquina::Piston::CachePiston.cache_key :thing, su.thing.id
    
    su.touch
    
    assert_not_equal key, LaMaquina::Piston::CachePiston.cache_key(:thing, su.thing.id)
  end

  def test_notifier_can_update_has_many
    greg        = guests(:greg)
    
    trait_keys  = greg.guest_traits.map{ |guest_trait| 
      { 
        gt: guest_trait, 
        key: LaMaquina::Piston::CachePiston.cache_key( :guest_trait, guest_trait.id ) 
      }
    }
    
    greg.touch

    trait_keys.each do |pair|
      assert_not_equal pair[:key], LaMaquina::Piston::CachePiston.cache_key(:guest_trait, pair[:gt].id)
    end
  end

  def test_notifier_can_update_has_many_through
    greg        = guests(:greg)
    
    trait_keys  = greg.traits.map{ |trait| 
      { 
        t: trait, 
        key: LaMaquina::Piston::CachePiston.cache_key( :trait, trait.id ) 
      }
    }
    
    greg.touch

    trait_keys.each do |pair|
      assert_not_equal pair[:key], LaMaquina::Piston::CachePiston.cache_key(:thing, pair[:t].id)
    end
  end

  def test_notifier_can_update_has_many_with_comm_object
    su          = admins(:su)
    
    trait_keys  = su.admin_traits.map{ |admin_trait| 
      { 
        gt: admin_trait, 
        key: LaMaquina::Piston::CachePiston.cache_key( :admin_trait, admin_trait.id ) 
      }
    }
    
    su.touch

    trait_keys.each do |pair|
      assert_not_equal pair[:key], LaMaquina::Piston::CachePiston.cache_key(:admin_trait, pair[:gt].id)
    end
  end

  def test_notifier_can_update_has_many_through_with_comm_object
    su          = admins(:su)
    
    trait_keys  = su.traits.map{ |trait| 
      { 
        t: trait, 
        key: LaMaquina::Piston::CachePiston.cache_key( :trait, trait.id ) 
      }
    }
    
    su.touch

    trait_keys.each do |pair|
      assert_not_equal pair[:key], LaMaquina::Piston::CachePiston.cache_key(:thing, pair[:t].id)
    end
  end
end