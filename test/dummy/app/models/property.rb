class Property < ActiveRecord::Base
  belongs_to :user, :polymorphic => true

  include LaMaquina::Notifier

  notifies_about :user, :polymorphic => true
end