class TestPiston < LaMaquina::Piston::Base
  def self.fire!(klass = "", id = nil)
    $fire_message = "#{klass}/#{id}"
  end
end