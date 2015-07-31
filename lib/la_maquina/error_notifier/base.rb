module LaMaquina
  module ErrorNotifier
    class Base
      
      def self.notify(error, details = {})
        throw "There's no ErrorNotifier set or id doesn't implement `notify` as it should."
      end
      
    end
  end
end