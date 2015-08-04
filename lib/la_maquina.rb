require "la_maquina/version"

module LaMaquina
  autoload :DependencyMap,        'la_maquina/dependency_map'
  autoload :Engine,               'la_maquina/engine'
  autoload :ErrorNotifier,        'la_maquina/error_notifier'
  autoload :Piston,               'la_maquina/piston'
  autoload :Notifier,             'la_maquina/notifier'

  mattr_accessor :error_notifier
  error_notifier ||= LaMaquina::ErrorNotifier::Base

  def self.format_object_name(object)
    object.class.to_s.demodulize.underscore
  end

  def self.format_class_name(klass)
    klass.to_s.demodulize.underscore
  end
end
