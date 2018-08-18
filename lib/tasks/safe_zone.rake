require 'open-uri'

namespace :safe_zone do
  assault_types = [
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

  theft_types = [
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

  burglary_types = [
    'Burglary (Business) 2nd Degree',
    'Burglary (Business) 3rd Degree',
    'Burglary (Residence) 1st Degree',
    'Burglary (Residence) 2nd Degree',
    'Burglary (Residence) 3rd Degree',
    'Domestic Burglary - 2nd Degree',
    'Domestic Burglary - 3rd Degree'
  ].freeze

  robbery_types = [
    'Robbery 1st Degree',
    'Robbery 2nd Degree',
    'Robbery 3rd Degree'
  ].freeze

  shooting_types = [
    'Shooting Into Occupied Building',
    'Throwing/Shooting into Occupied Vehicle'
  ].freeze

  rape_types = [
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

  desc "fetch crime data"
  task fetch_data: :environment do
    URLS.keys.each do |file_name|
      open('tmp/' << file_name.to_s, 'wb') do |file|
        file << open(URLS[file_name]).read
      end
      CSV.foreach("tmp/#{file_name}") do |row|
        zipcode = row[2]
        offense = row[5]
        location = Location.find_or_create_by(zipcode: zipcode)
        # based on what the assault type is, add a number to the location's field
        case offense
        when *assault_types
          location.update(assault_count: location.assault_count + 1)
        when *shooting_types
          location.update(shooting_count: location.shooting_count + 1)
        when *rape_types
          location.update(rape_count: location.rape_count + 1)
        when *theft_types
          location.update(theft_count: location.theft_count + 1)
        when *burglary_types
          location.update(burglary_count: location.burglary_count + 1)
        when *robbery_types
          location.update(robbery_count: location.robbery_count + 1)
        else     
        end
      end
    end
    # get crime data 
    # get csv
    # for each zipcode in csv:
    #   make location
    #   make stats collection
    #     for each type array
    #       for each value in type:
    #         add corresponding value from csv to type attribute value of statcollection
    #       end
    #     e.g.
    #     assault_types.each do |type|
    #       statsCollection.update(assaultCount: statCollection.assaultCount + file.get_offense(type).value
    #     etc. for other typesgi
    #   generate score for that location
    #   based on stats collection
    # end
  end
end
