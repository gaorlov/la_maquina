module LaMaquina
  module Piston
    class SunspotPiston < LaMaquina::Piston::Base

      class << self
        def fire!( notified_class, id, notifier_class = "" )  
          target_class = map.mapping_for notified_class, id
          target       = target_class.find(id)
          target.solr_index!
        rescue => e
          LaMaquina.error_notifier.notify(  e,
                                            notified_class: klass,
                                            notified_id: id,
                                            notifier_class: notifier_class )
        end
        
        attr_accessor :map
      end
      self.map = LaMaquina::DependencyMap::ConstantMap.new
    end
  end
end