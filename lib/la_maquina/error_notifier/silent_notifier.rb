module LaMaquina
  module ErrorNotifier
    class SilentNotifier < LaMaquina::ErrorNotifier::Base

      def self.notify(error, detail)
        # don't blame me! you're the one who didn't set the notifier!
      end
    end
  end
end