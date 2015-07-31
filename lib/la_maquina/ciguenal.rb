module LaMacquina
  class Ciguenal

    class << self
      def self.notify!(klass = "", id = nil)
        pistons.each do |piston|
          piston.fire! klass, id
        end
      end

      def self.piston(piston)
        self.pistons << piston
      end

      protected

      attr_accessor :pistons
      self.pistons = []
    end
  end
end
