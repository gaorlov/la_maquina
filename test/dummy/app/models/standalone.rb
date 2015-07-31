class Standalone < ActiveRecord::Base
  include LaMaquina::Volante

  notifies :self, :comm_object => ::ExplodingCommObject
end