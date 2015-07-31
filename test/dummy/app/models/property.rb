class Property < ActiveRecord::Base
  belongs_to :user, :polymorphic => true

  include LaMaquina::Volante


  notifies :user, :polymorphic => true
end