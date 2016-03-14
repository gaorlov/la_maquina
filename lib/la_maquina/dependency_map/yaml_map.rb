module LaMaquina
  module DependencyMap
    class YamlMap < LaMaquina::DependencyMap::Base
      def find(*args)
        submap = map
        args.each do |key|
          submap = submap[key]
          break if submap.blank?
        end
        submap
      end
    end
  end
end