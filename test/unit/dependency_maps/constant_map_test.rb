require 'test_helper'


class ConstantMapTest < ActiveSupport::TestCase
  def setup
    @admin = admins(:wheel)
    @map = LaMaquina::DependencyMap::ConstantMap.new
  end

  def test_can_load_map
    assert Admin, @map.mapping_for(:admin)
  end

  def test_catches_mapless_lookup
    @map.mapping_for :lol
    
    assert_equal NoMethodError, $error.class
  end

  def test_is_with_indifferent_access
    assert Admin, @map.mapping_for("admin")
    assert Admin, @map.mapping_for(:admin)
  end

  def test_can_go_to_any_depth
    map = LaMaquina::DependencyMap::YamlMap.new( Rails.root + 'config/la_maquina/dependency_maps/deep_map.yml' )
    assert_equal "trait", map.mapping_for( "admin", "trait" )
    assert_equal "b", map.mapping_for( "guest", "trait", 1 )
  end
end