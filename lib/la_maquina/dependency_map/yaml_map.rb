module LaMaquina
  module DependencyMap
    class YamlMap < LaMaquina::DependencyMap::Base
      def find(*args)
        submap = map
        args.each do |key|
          submap = submap[key]
        end
        submap
      rescue => e
        LaMaquina.error_notifier.notify( e )
      end
    end
  end
end