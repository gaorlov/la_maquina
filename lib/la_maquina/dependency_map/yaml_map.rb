module LaMaquina
  module DependencyMap
    class YamlMap < LaMaquina::DependencyMap::Base
      def find(*args)
        submap = map
        args.each do |key|
          submap = submap[key]
          if submap.blank?
            raise LaMaquina::Errors::InvalidMappingError.new("#{args} not found in dependency map")
          end
        end
        submap
      end
    end
  end
end