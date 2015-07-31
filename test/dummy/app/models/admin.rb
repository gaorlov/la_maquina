class Admin < ActiveRecord::Base
  has_many :admin_traits
  has_many :traits, :through => :admin_traits

  has_many :properties, :as => :user

  include LaMaquina::Volante
  notifies :self

  notifies :self, :using => ::DummyCommObject
end