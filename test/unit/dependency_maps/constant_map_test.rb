require 'test_helper'


class ConstantMapTest < ActiveSupport::TestCase
  def setup
    @admin = admins(:wheel)
    @map = LaMaquina::DependencyMap::ConstantMap.new
  end

  def test_can_load_map
    assert Admin, @map.find(:admin)
  end

  def test_throws_on_mapless_lookup
    assert_raise NameError do
      @map.find :lol
    end
  end

  def test_is_with_indifferent_access
    assert Admin, @map.find("admin")
    assert Admin, @map.find(:admin)
  end

  def test_can_go_to_any_depth
    map = LaMaquina::DependencyMap::YamlMap.new( Rails.root + 'config/la_maquina/dependency_maps/deep_map.yml' )
    assert_equal "trait", map.find( "admin", "trait" )
    assert_equal "b", map.find( "guest", "trait", 1 )
  end
end