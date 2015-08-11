require 'test_helper'


class YamlMapTest < ActiveSupport::TestCase
  def setup
    @admin = admins(:wheel)
    @admin.index!
    @map = LaMaquina::DependencyMap::YamlMap.new( Rails.root + 'config/la_maquina/dependency_maps/sunspot_piston.yml' )
  end

  def test_can_load_map
    assert 'admin', @map.find(:admin)
  end

  def test_catches_mapless_lookup
    map = LaMaquina::DependencyMap::YamlMap.new
    map.find :admin
    
    assert_equal NoMethodError, $error.class
  end

  def test_is_with_indifferent_access
    assert :admin, @map.find("admin")
    assert :admin, @map.find(:admin)
  end

  def test_can_go_to_any_depth
    map = LaMaquina::DependencyMap::YamlMap.new( Rails.root + 'config/la_maquina/dependency_maps/deep_map.yml' )
    assert_equal "trait", map.find( "admin", "trait" )
    assert_equal "b", map.find( "guest", "trait", 1 )
  end
end