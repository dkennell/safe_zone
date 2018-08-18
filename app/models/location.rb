class Location < ApplicationRecord
  validates_inclusion_of :score, in: 1..100
  validates :zipcode, :assault_count, :shooting_count, 
            :rape_count, :theft_count, :burglary_count, 
            :robbery_count, presence: true
  
  def score_phrase
    case score
    when 1..10
      'Very very much not safe'
    when 11..20
      'Very much not safe'
    when 21..30
      'Much not safe'
    when 31..40
      'Not safe'
    when 41..50
      'Use caution'
    when 51.60
      'Be cautious'
    when 61..70
      'Eh'
    when 71..80
      'Hide your wallet'
    when 81..90
      'Pretty safe'
    when 91..100
      'You fuckin did it'
    else
      'Invalid score'
    end
  end
end
