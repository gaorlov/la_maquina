module LaMaquina
  module ErrorNotifier
    class Base
      
      def self.notify(error, detail = {})
        throw "A piston has to implement 'notify'"
      end
      
    end
  end
end