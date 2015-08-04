class AdminTrait < ActiveRecord::Base
  belongs_to :user, :class_name => "Admin"
  belongs_to :thing, :class_name => "Trait"

  include LaMaquina::Notifier

  notifies_about :user, :class => Admin
  notifies_about :thing, :class_name => "Trait"
end