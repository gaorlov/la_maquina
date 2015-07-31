class Machete < ActiveRecord::Base

  belongs_to :danny_trejo
  
  include LaMaquina::Volante
  notifies :danny_trejo

end