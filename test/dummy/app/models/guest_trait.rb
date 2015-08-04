class GuestTrait < ActiveRecord::Base
  belongs_to :guest
  belongs_to :trait

  include LaMaquina::Notifier

  notifies_about :guest
  notifies_about :trait
end