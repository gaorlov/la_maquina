require 'test_helper'

class EngineTest < ActiveSupport::TestCase
  
  def setup
    @admin = admins(:wheel)
  end
  
  def test_can_install_pistons
    # the dummy app installs stuff into the Engine
    assert LaMaquina::Engine.send(:pistons).include? PrimitivePiston
  end
 
  def test_can_fire_pistons
    LaMaquina::Engine.notify!("admin", @admin.id)
  end

  def test_bad_piston_doesnt_block
    LaMaquina::Engine.install ExplodingPiston
    
    $error = nil
    $deets = nil

    LaMaquina::Engine.notify! "admin", @admin.id

    assert_equal RuntimeError, $error.class
    assert_equal "NOPE! LOL", $error.to_s
    assert_equal ExplodingPiston, $deets[:misfiring_piston]

    assert_equal "admin/#{@admin.id}", $fire_message
  end
end