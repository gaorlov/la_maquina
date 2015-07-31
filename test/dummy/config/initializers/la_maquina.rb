LaMaquina::Piston::CachePiston.redis = Redis::Namespace.new(:cache_piston, redis: Redis.new)
LaMaquina::Ciguenal.install LaMaquina::Piston::CachePiston, TestPiston
LaMaquina.error_notifier = LaMaquina::ErrorNotifier::TestNotifier
