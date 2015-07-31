LaMaquina::Pistons::CachePiston.redis = Redis::Namespace.new(:cache_piston, redis: MyRedisInstance)
LaMaquina::Ciguenal.install LaMaquina::Piston::CachePiston
LaMaquina::Cinegual.error_notifier = LaMaquina::ErrorNotifier::SilentNotifier