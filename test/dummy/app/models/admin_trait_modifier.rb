class AdminTraitModifier < ActiveRecord::Base
  belongs_to :admin_trait

  include LaMaquina::Notifier

  notifies_about :user, :through => :admin_trait, :class_name => "Admin"
  notifies_about :thing, :through => :admin_trait, :class => Trait
end