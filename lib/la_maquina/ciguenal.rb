module LaMacquina
  class Ciguenal

    class << self
      def self.notify!(klass = "", id = nil)
        pistons.each do |piston|
          piston.fire! klass, id
        end
      end

      def self.add_piston(*pistons)
        pistons.each do |piston|
          self.pistons piston
        end
      end

      protected

      attr_accessor :pistons
      self.pistons = []
    end
  end
end
