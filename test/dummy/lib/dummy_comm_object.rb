class DummyCommObject
  def self.notify params
    $dummy_params = params
  end
end