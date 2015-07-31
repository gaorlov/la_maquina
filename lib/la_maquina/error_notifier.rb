module LaMaquina
  module ErrorNotifier
    autoload :Base,                 'la_maquina/error_notifier/base'
    autoload :HoneybadgerNotifier,  'la_maquina/error_notifier/honeybadger_notifier'
  end
end