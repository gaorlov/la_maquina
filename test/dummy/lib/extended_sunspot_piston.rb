class ExtendedSunspotPiston < LaMaquina::Piston::SunspotPiston
  class << self
    def fire!( notified_class, id, notifier_class = "" )
      if yaml_map.mapping_for notified_class
        super
        $last_reindexed = notified_class
      end
    end

    attr_accessor :yaml_map
  end
  self.map = LaMaquina::DependencyMap::ConstantMap.new
end
