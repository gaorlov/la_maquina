class Guest < ActiveRecord::Base
  has_many :guest_traits
  has_many :traits, through: :guest_traits
  
  has_one  :guest_thing
  has_one  :thing, through: :guest_thing

  has_many :properties, :as => :user

  include LaMaquina::Notifier

  notifies_about :self

  notifies_about :traits
  notifies_about :guest_traits

  notifies_about :thing
  notifies_about :guest_thing
end