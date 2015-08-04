class GuestTraitModifier < ActiveRecord::Base
  belongs_to :guest_trait

  include LaMaquina::Notifier

  notifies_about :guest, :through => :guest_trait
end