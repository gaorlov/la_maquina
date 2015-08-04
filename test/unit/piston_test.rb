require 'test_helper'


class PistonTest < ActiveSupport::TestCase
  def test_base_piston_raises_exception
    assert_raises RuntimeError do 
      LaMaquina::Piston::Base.fire!("class", 1, "other_class")
    end
  end
end