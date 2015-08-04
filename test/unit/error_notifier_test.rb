require 'test_helper'


class ErroNotifierTest < ActiveSupport::TestCase
  def setup
    @admin = admins(:wheel)
    LaMaquina.error_notifier = LaMaquina::ErrorNotifier::Base
  end

  def test_base_notifier_raises_exception
    assert_raises RuntimeError do 
      thing = standalones(:thing)
      thing.value = "something new"
      thing.save
    end
  end

  def teardown
    LaMaquina.error_notifier = TestNotifier
  end
end