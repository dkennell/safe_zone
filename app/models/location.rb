class Location < ApplicationRecord
  validates :zipcode, presence: true
end
