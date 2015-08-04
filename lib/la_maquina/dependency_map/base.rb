module LaMaquina
  module DependencyMap
    class Base
      def initialize( path = nil )
        if path
          map = YAML.load_file(path).with_indifferent_access
        end
      end

      def mapping_for(*args)
        raise "A dependency map has to implement 'mapping_for'"
      end

      protected

      attr_accessor :map
    end
  end
end