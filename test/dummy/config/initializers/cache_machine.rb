CacheMachine.redis = Redis::Namespace.new(:cache_machine, :redis => Redis.new)
CacheMachine.update_error_handler = -> (error, details){ $error = error; $deets = details }