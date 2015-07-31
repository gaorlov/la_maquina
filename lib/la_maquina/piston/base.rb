module LaMaquina
  module Piston
    class Base

      def self.fire!(klass = "", id = nil)
        throw "A piston has to implement 'fire!'"
      end
      
    end
  end
end
