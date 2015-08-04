class Guest < ActiveRecord::Base
  has_many :guest_traits
  has_many :traits, :through => :guest_traits

  has_many :properties, :as => :user

  include LaMaquina::Notifier

  notifies_about :self
end