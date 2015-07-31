class AdminTrait < ActiveRecord::Base
  belongs_to :user, :class_name => "Admin"
  belongs_to :thing, :class_name => "Trait"

  include LaMaquina::Volante

  notifies :user, :class => Admin
  notifies :thing, :class_name => "Trait"
end