require "la_maquina/version"

module LaMaquina
  autoload :Ciguenal,     'la_maquina/ciguenal'
  autoload :Piston,       'la_maquina/piston'
  autoload :Volante,      'la_maquina/volante'

  autoload :CachePiston,  'la_maquina/pistons/cache_piston'


  mattr_accessor :update_error_handler

  def self.format_object_name(object)
    object.class.to_s.demodulize.underscore
  end

  def self.format_class_name(klass)
    klass.to_s.demodulize.underscore
  end
end
