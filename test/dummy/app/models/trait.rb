class Trait < ActiveRecord::Base
  has_many :guest_traits
  has_many :admin_traits
end