class TestNotifier < LaMaquina::ErrorNotifier::Base
  def self.notify(error, details = {})
    $error    = error
    $details  = details
  end
end