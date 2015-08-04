class Admin < ActiveRecord::Base
  has_many :admin_traits
  has_many :traits, :through => :admin_traits

  has_many :properties, :as => :user

  searchable do 
    text :name
  end

  include LaMaquina::Notifier
  notifies_about :self

  notifies_about :self, using: ::DummyCommObject
end