module LaMaquina
  module DependencyMap
    class Base
      def initialize( path = nil )
        if path
          self.map = YAML.load_file(path).with_indifferent_access
        end
      end

      def find(*args)
        raise "A dependency map has to implement 'find'"
      end

      protected

      attr_accessor :map
    end
  end
end