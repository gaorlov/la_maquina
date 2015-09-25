class AdminTrait < ActiveRecord::Base
  belongs_to :user, :class_name => "Admin"
  belongs_to :blah, :class_name => "Trait"

  include LaMaquina::Notifier

  notifies_about :user, :class => Admin
  notifies_about :blah, :class_name => "Trait"
end