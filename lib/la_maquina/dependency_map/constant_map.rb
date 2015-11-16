module LaMaquina
  module DependencyMap
    class ConstantMap < LaMaquina::DependencyMap::Base
      
      def find(notified_class)
        notified_class.to_s.camelize.constantize
      end
    end
  end
end