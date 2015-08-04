module LaMaquina
  module Piston
    class Base

      def self.fire!( notified_class, id, notifier_class = "" )
        raise "A piston has to implement 'fire!'"
      end
      
    end
  end
end
