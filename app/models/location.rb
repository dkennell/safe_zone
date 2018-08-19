class Location < ApplicationRecord
  validates_inclusion_of :score, in: 1..100
  validates :zipcode, :assault_count, :shooting_count,
            :rape_count, :theft_count, :burglary_count,
            :robbery_count, presence: true

  def score_phrase
    case score
    when 1..10
      'super dangerous'
    when 11..20
      'super dangerous'
    when 21..30
      'super sketchy'
    when 31..40
      'super sketchy'
    when 41..50
      'rather sketchy'
    when 51.60
      'rather sketchy'
    when 61..70
      'somewhat sketchy'
    when 71..80
      'somewhat sketchy'
    when 81..90
      'usually safe'
    when 91..100
      'usually safe'
    else
      '[invalid score]'
    end
  end
end
