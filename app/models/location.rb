class Location < ApplicationRecord
  validates_inclusion_of :score, in: 1..100
  validates :zipcode, :assault_count, :shooting_count,
            :rape_count, :theft_count, :burglary_count,
            :robbery_count, presence: true

  def score_phrase
    case score
    when 1..10
      'very dangerous'
    when 11..20
      'usually dangerous'
    when 21..30
      'mostly dangerous'
    when 31..40
      'somewhat dangerous'
    when 41..50
      'a little dangerous'
    when 51..60
      'a little safe'
    when 61..70
      'somewhat safe'
    when 71..80
      'mostly safe'
    when 81..90
      'usually safe'
    when 91..100
      'very safe'
    else
      '[invalid score]'
    end
  end

  def score_color
    case score
    when 1..10
      '#FF3232'
    when 11..20
      '#FF4130'
    when 21..30
      '#FF7830'
    when 31..40
      '#FF8630'
    when 41..50
      '#FF9730'
    when 51.60
      '#F4B22E'
    when 61..70
      '#F7C12E'
    when 71..80
      '#E5CF2B'
    when 81..90
      '#8FC46A'
    when 91..100
      '#5AA863'
    else
      '#FFFFFF'
    end
  end
end
