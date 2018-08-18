class Location < ApplicationRecord
  validates :zipcode, :assault_count, :shooting_count, 
            :rape_count, :theft_count, :burglary_count, 
            :robbery_count, presence: true
end
