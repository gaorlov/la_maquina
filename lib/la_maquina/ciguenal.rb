module LaMaquina
  class Ciguenal

    class << self
      protected

      attr_accessor :pistons
    end
    self.pistons = []

    class << self 

      def notify!(klass = "", id = nil)
        pistons.each do |piston|
          piston.fire! klass, id
        end
      end

      def install(*attrs)
        attrs.each do |piston|
          self.pistons << piston
        end
      end

    end
  end
end
