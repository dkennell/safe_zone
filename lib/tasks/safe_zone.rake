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

  desc "fetch crime data"
  task fetch_data: :environment do
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
    #     etc. for other types
    #   generate score for that location
    #   based on stats collection
    # end
  end

end
