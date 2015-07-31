class DummyCacheMachineCommObject
  def self.touch_cache params
    $dummy_cache_params = params
  end
end