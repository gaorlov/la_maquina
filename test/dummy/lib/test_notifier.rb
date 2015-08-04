class TestNotifier < LaMaquina::ErrorNotifier::Base
  def self.notify(error, details = {})
    $error = error
    $deets = details
  end
end