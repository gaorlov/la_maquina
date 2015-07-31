require 'test_helper'

class LaMaquinaTest < ActiveSupport::TestCase

  def test_object_name_formatting
    assert_equal "admin",      LaMaquina.format_object_name(admins(:su))
    assert_equal "admin_trait", LaMaquina.format_object_name(admin_traits(:wheels_something_else))
  end


  def test_class_name_formatting
    assert_equal "admin",      LaMaquina.format_class_name(Admin)
    assert_equal "admin_trait", LaMaquina.format_class_name(AdminTrait)
  end
end