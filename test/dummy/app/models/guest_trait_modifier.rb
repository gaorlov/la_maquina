class GuestTraitModifier < ActiveRecord::Base
  belongs_to :guest_trait

  include LaMaquina::Volante


  notifies :guest, :through => :guest_trait
end