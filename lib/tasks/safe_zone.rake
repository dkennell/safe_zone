require 'open-uri'

namespace :safe_zone do
  ASSAULT_TYPES = [
    'Assault  1st Degree',
    'Assault  2nd Degree',
    'Attempt to Commit Murder',
    'Murder',
    'Use of Pepper Spray, etc',
    'Child Abuse-Aggravated-Family-2nd Degree',
    'Domestic Assault - 2nd Degree',
    'Domestic Assault 1st Degree',
    'Domestic Strangulation or Suffocation',
    'Miscellaneous Theft-3rd Degree',
    'Child Abuse-Aggravated-Family'
  ].freeze

  THEFT_TYPES = [
    'Auto Theft - 1st Degree',
    'Shoplifting - 4th Degree',
    'Shoplifting 3rd Degree',
    'Shoplifting-1st Degree',
    'Shoplifting-2nd Degree',
    'Theft - TOP 1st Degree',
    'Theft - TOP 2nd Degree',
    'Theft - TOP 3rd Degree',
    'Theft - TOP 4th Degree',
    'Theft from Residence - 3rd Degree',
    'Theft from Residence 4th Degree',
    'Theft of Credit/Debit Card',
    'Theft of Lost Property 3rd',
    'Theft of Lost Property 4th Degree',
    'Theft of Lost Property-1st Degree',
    'Theft of Lost Property-2nd Degree',
    'Theft of Tag 3rd',
    'Theft of Tag 4th Degree',
    'Theft-Bicycle-3rd Degree',
    'Theft-Firearms-2nd Degree',
    'Theft-From Coin Machine - 4th Degree',
    'Theft-From Public Building- 4th Degree',
    'Theft-From Public Building-1st Degree',
    'Theft-From Public Building-2nd Degree',
    'Theft-From Public Building-3rd Degree',
    'Theft-From Residence-1st Degree',
    'Theft-From Residence-2nd Degree',
    'Theft-Vehicle Parts-1st Degree',
    'Theft-Vehicle Parts-2nd Degree',
    'Theft-Vehicle Parts-3rd Degree',
    'Theft-Vehicle Parts-4th Degree',
    'Theft-From Banking Institution-3rd Degree',
    'Theft-From Yards-3rd Degree',
    'Theft-From Yards-4th Degree'
  ].freeze

  BURGLARY_TYPES = [
    'Burglary (Business) 2nd Degree',
    'Burglary (Business) 3rd Degree',
    'Burglary (Residence) 1st Degree',
    'Burglary (Residence) 2nd Degree',
    'Burglary (Residence) 3rd Degree',
    'Domestic Burglary - 2nd Degree',
    'Domestic Burglary - 3rd Degree'
  ].freeze

  ROBBERY_TYPES = [
    'Robbery 1st Degree',
    'Robbery 2nd Degree',
    'Robbery 3rd Degree'
  ].freeze

  SHOOTING_TYPES = [
    'Shooting Into Occupied Building',
    'Throwing/Shooting into Occupied Vehicle'
  ].freeze

  RAPE_TYPES = [
    'Rape - 1st Degree',
    'Rape - 2nd Degree',
    'Sodomy - 1st Degree',
    'Sodomy - 2nd Degree'
  ].freeze

  URLS = {
    'north.csv': 'https://data.birminghamal.gov/dataset/eb9bca6d-06e1-4130-9b9c-c9a9a92d5d5a/resource/3292391a-d538-4604-a5d2-72bbf8fb42ab/download/open-data-portal---north-thru-jun-30-2018-csv.csv',
    'south.csv': 'https://data.birminghamal.gov/dataset/70fa50d3-5c65-4f5c-b352-f8c3516c25f6/resource/368fec83-6503-41e9-a0f1-e8d062a4c821/download/open-date-portal---south-thru-jun-30-2018-csv.csv',
    'east.csv': 'https://data.birminghamal.gov/dataset/0a22b9f3-eb07-40f6-b52d-d31ff43c6b54/resource/9d13f610-5538-4d68-81f8-5a0fb514512a/download/open-data-portal---east-thru-jun-30-2018-csv.csv',
    'west.csv': 'https://data.birminghamal.gov/dataset/b3fab069-4df4-4335-b972-eb2fef7ce218/resource/83d01fdd-222d-47b0-b50b-31cfe88b7d0f/download/open-data-portal---west-thru-jun-30-2018-csv.csv'
  }

  ASSAULT_COEF = 60
  RAPE_COEF = 55
  SHOOTING_COEF = 50
  ROBBERY_COEF = 45
  BURGLARY_COEF = 40
  THEFT_COEF = 35

  desc "fetch all data and generate scores"
  task fetch_data: :environment do
    Location.delete_all
    fetch_crime_data
    fetch_population_data
    calculate_location_scores
    setup_polygons
  end

  def fetch_crime_data
    p 'Fetching crime data...'
    URLS.keys.each_with_index do |file_name, index|
      open('tmp/' << file_name.to_s, 'wb') do |file|
        file << open(URLS[file_name]).read
      end
      CSV.foreach("tmp/#{file_name}") do |row|
        zipcode = row[2]
        next unless zipcode.present? && zipcode.to_i != 0
        offense = row[4]
        location = Location.find_or_create_by(zipcode: zipcode)
        # based on what the assault type is, add a number to the location's field
        case offense
        when *ASSAULT_TYPES
          location.increment!(:assault_count)
        when *SHOOTING_TYPES
          location.increment!(:shooting_count)
        when *RAPE_TYPES
          location.increment!(:rape_count)
        when *THEFT_TYPES
          location.increment!(:theft_count)
        when *BURGLARY_TYPES
          location.increment!(:burglary_count)
        when *ROBBERY_TYPES
          location.increment!(:robbery_count)
        else     
        end
        print '.'
      end
      puts "File #{file_name} processed. (#{index + 1}/#{URLS.size})"
    end
  end

  def fetch_population_data
    p 'Fetching population data...'
    CSV.foreach('csv/population_data.csv') do |row|
      location = Location.find_by(zipcode: row[0])
      if location.present?
        location.update(population: row[1].to_i)
      end
    end
  end

  def calculate_location_scores
    p 'Calculating scores...'
    Location.find_each do |location|
      pop = location.population
      next if pop.blank?

      assaults = location.assault_count
      rapes = location.rape_count
      shootings = location.shooting_count
      robberies = location.robbery_count
      burgs = location.burglary_count
      thefts = location.theft_count

      score = ([
        (assaults.to_f / pop) * ASSAULT_COEF,
        (rapes.to_f / pop) * RAPE_COEF,
        (shootings.to_f / pop) * SHOOTING_COEF,
        (robberies.to_f / pop) * ROBBERY_COEF,
        (burgs.to_f / pop) * BURGLARY_COEF,
        (thefts.to_f / pop) * THEFT_COEF
      ].map{ |el| 1 - el }.inject(:+).to_f / 6) * 100

      location.update(score: score)
    end
  end

  def setup_polygons
    file = File.read('app/assets/json/birmingham_polygons.json')
    data_hash = JSON.parse(file)
    Location.all.each do |location|
      zipcode = location.zipcode.to_i
      zipcode_hash = {}
      # Find index of zipcode
      data_hash.dig('features').each do |full_hash|
        zipcode_hash = full_hash.dig('geometry').dig('coordinates').dig(0) if full_hash.dig('properties').dig('ZIPCODE') == zipcode
      end
      vals = {values: []}
      zipcode_hash.each do |combo|
        vals[:values] << {lat: combo[1], lng: combo[0]}
      end
      if vals[:values].length.positive?
        location.update_attributes(polygon: vals.to_json)
      end
    end
  end
end

