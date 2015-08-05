module LaMaquina
  module ErrorNotifier
    class HoneybadgerNotifier < LaMaquina::ErrorNotifier::Base
      def notify(error, details = {})
        Honeybadger.notify( :error_class => "LaMaquinaError: #{error.class.name}",
                            :error_message => error.message,
                            :parameters => details
                          )
      end
    end
  end
end