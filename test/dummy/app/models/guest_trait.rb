class GuestTrait < ActiveRecord::Base
  belongs_to :guest
  belongs_to :trait

  include LaMaquina::Volante

  notifies :guest
  notifies :trait
end