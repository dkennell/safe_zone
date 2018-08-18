require 'open-uri'
require 'csv'

namespace :birmingham do
  desc 'Parses data'
  task parse: :environment do
    URLS.keys.each do |file_name|
      # first row should be ['Block', 'Street Name', 'Case Address Zip', 'Case Occurred From Date',
      # 'Case Offense Statute Description', 'Reporting District', nil, nil, nil...]
      # Each row should have 253 values (why, birmingham?)
      CSV.foreach('tmp/' << file_name.to_s) do |row|
        investigate_row(row)
        aggregate_row(row)
      end
      puts OFFENSES.to_s
    end
  end

  desc 'Downloads data'
  task download: :environment do
    URLS.keys.each do |file_name|
      open('tmp/' << file_name.to_s, 'wb') do |file|
        file << open(URLS[file_name]).read
      end
    end
  end

  private

  OFFENSES = {}

  URLS = {
      'north.csv': 'https://data.birminghamal.gov/dataset/eb9bca6d-06e1-4130-9b9c-c9a9a92d5d5a/resource/3292391a-d538-4604-a5d2-72bbf8fb42ab/download/open-data-portal---north-thru-jun-30-2018-csv.csv',
      'south.csv': 'https://data.birminghamal.gov/dataset/70fa50d3-5c65-4f5c-b352-f8c3516c25f6/resource/368fec83-6503-41e9-a0f1-e8d062a4c821/download/open-date-portal---south-thru-jun-30-2018-csv.csv',
      'east.csv': 'https://data.birminghamal.gov/dataset/0a22b9f3-eb07-40f6-b52d-d31ff43c6b54/resource/9d13f610-5538-4d68-81f8-5a0fb514512a/download/open-data-portal---east-thru-jun-30-2018-csv.csv',
      'west.csv': 'https://data.birminghamal.gov/dataset/b3fab069-4df4-4335-b972-eb2fef7ce218/resource/83d01fdd-222d-47b0-b50b-31cfe88b7d0f/download/open-data-portal---west-thru-jun-30-2018-csv.csv'
  }

  def investigate_row(row)
    puts 'not 253' if row.length != 253
    (0..5).to_a.each do |val|
      puts 'nil in 6: ' << row.slice(0, 5).to_s if row.dig(val).nil?
    end
  end

  def aggregate_row(row)
    # 'Case Offense Statute Description': index=4
    OFFENSES[row.dig(4)] += 1 if OFFENSES[row.dig(4)].present? && row.dig(4).present?
    OFFENSES[row.dig(4)] = 1 unless OFFENSES[row.dig(4)].present? && row.dig(4).present?
  end

  F = {
       'Case Offense Statute Description':3,
       'Assault  1st Degree':127,
       'Assault  2nd Degree':98,
       'Attempt to Commit Murder':78,
       'Auto Theft - 1st Degree':552,
       'Burglary (Business) 2nd Degree':15,
       'Burglary (Business) 3rd Degree':183,
       'Burglary (Residence) 1st Degree':28,
       'Burglary (Residence) 2nd Degree':37,
       'Burglary (Residence) 3rd Degree':769,
       'Child Abuse-Aggravated-Family-2nd Degree':2,
       'Domestic Assault - 2nd Degree':60,
       'Domestic Assault 1st Degree':8,
       'Domestic Burglary - 2nd Degree':14,
       'Domestic Burglary - 3rd Degree':35,
       'Domestic Menacing':151,
       'Domestic Strangulation or Suffocation':130,
       'Menacing':283,
       'Miscellaneous Theft-3rd Degree':7,
       'Murder':40,
       'Possession of Burglars Tools':7,
       'Rape - 1st Degree':34,
       'Rape - 2nd Degree':15,
       'Robbery 1st Degree':245,
       'Robbery 2nd Degree':35,
       'Robbery 3rd Degree':57,
       'Shooting Into Occupied Building':275,
       'Shoplifting - 4th Degree':340,
       'Shoplifting 3rd Degree':25,
       'Shoplifting-1st Degree':2,
       'Shoplifting-2nd Degree':6,
       'Sodomy - 1st Degree':7,
       'Theft - TOP 1st Degree':134,
       'Theft - TOP 2nd Degree':297,
       'Theft - TOP 3rd Degree':431,
       'Theft - TOP 4th Degree':763,
       'Theft from Residence - 3rd Degree':41,
       'Theft from Residence 4th Degree':77,
       'Theft of Credit/Debit Card':5,
       'Theft of Lost Property 3rd':18,
       'Theft of Lost Property 4th Degree':36,
       'Theft of Lost Property-1st Degree':2,
       'Theft of Lost Property-2nd Degree':11,
       'Theft of Tag 3rd':17,
       'Theft of Tag 4th Degree':367,
       'Theft-Bicycle-3rd Degree':1,
       'Theft-Firearms-2nd Degree':3,
       'Theft-From Coin Machine - 4th Degree':2,
       'Theft-From Public Building- 4th Degree':6,
       'Theft-From Public Building-1st Degree':2,
       'Theft-From Public Building-2nd Degree':2,
       'Theft-From Public Building-3rd Degree':6,
       'Theft-From Residence-1st Degree':15,
       'Theft-From Residence-2nd Degree':21,
       'Theft-Vehicle Parts-1st Degree':4,
       'Theft-Vehicle Parts-2nd Degree':5,
       'Theft-Vehicle Parts-3rd Degree':14,
       'Theft-Vehicle Parts-4th Degree':17,
       'Throwing/Shooting into Occupied Vehicle':146,
       'Unlawful Breaking/Entering into Vehicle':1011,
       'Unauthorized Use of Vehicle':295,
       'Use of Pepper Spray, etc':3,
       'Child Abuse-Aggravated-Family':1,
       'Sodomy - 2nd Degree':6,
       'Theft-From Banking Institution-3rd Degree':1,
       'Theft-From Yards-3rd Degree':4,
       'Theft-From Yards-4th Degree':1
  }
end
