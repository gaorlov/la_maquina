class Admin < ActiveRecord::Base
  has_many :admin_traits, foreign_key: :user_id
  has_many :traits, through: :admin_traits, source: :blah
  has_one  :admin_thing
  has_one  :thing, through: :admin_thing

  has_many :properties, as: :user

  searchable do 
    text :name
  end

  include LaMaquina::Notifier
  notifies_about :self

  notifies_about :self,         using: ::DummyCommObject

  notifies_about :traits,       using: ::CleverCommObject
  notifies_about :admin_traits, using: ::CleverCommObject

  notifies_about :thing,        using: ::CleverCommObject
  notifies_about :admin_thing,  using: ::CleverCommObject
end