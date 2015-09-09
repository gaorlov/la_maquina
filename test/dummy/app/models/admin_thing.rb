class AdminThing < ActiveRecord::Base
  belongs_to :admin
  belongs_to :thing
end