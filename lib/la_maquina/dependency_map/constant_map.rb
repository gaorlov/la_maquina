module LaMaquina
  module DependencyMap
    class ConstantMap < LaMaquina::DependencyMap::Base
      
      def mapping_for(notified_class, id)
        notified_class.camelize.constantize
      rescue => e
        LaMaquina.error_notifier.notify(  e,
                                          missing_class: notified_class )
      end
    end
  end
end