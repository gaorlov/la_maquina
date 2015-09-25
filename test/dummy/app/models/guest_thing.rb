class GuestThing < ActiveRecord::Base
  belongs_to :guest
  belongs_to :thing
end