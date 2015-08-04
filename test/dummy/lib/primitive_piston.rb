class PrimitivePiston < LaMaquina::Piston::Base
  def self.fire!( notified_class, id, notifier_class = "" )
    $fire_message = "#{notified_class}/#{id}"
  end
end