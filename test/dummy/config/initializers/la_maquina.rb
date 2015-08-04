LaMaquina::Piston::CachePiston.redis = Redis::Namespace.new(:cache_piston, redis: Redis.new)
ExtendedSunspotPiston.yaml_map = LaMaquina::DependencyMap::YamlMap.new( Rails.root + 'config/la_maquina/dependency_maps/sunspot_piston.yml' )

LaMaquina::Engine.install LaMaquina::Piston::CachePiston,
                          LaMaquina::Piston::SunspotPiston,
                          PrimitivePiston,
                          ExtendedSunspotPiston
                          
LaMaquina.error_notifier = TestNotifier
