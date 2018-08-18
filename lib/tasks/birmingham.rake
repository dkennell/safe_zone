require 'open-uri'
require 'csv'

namespace :birmingham do
  desc 'Parses data'
  task parse: :environment do
    URLS.keys.each do |file_name|
      # first row should be ["Block", "Street Name", "Case Address Zip", "Case Occurred From Date",
      # "Case Offense Statute Description", "Reporting District", nil, nil, nil...]
      # Each row should have 253 values (why, birmingham?)
      CSV.foreach('tmp/' << file_name.to_s) do |row|
        investigate_row(row)
      end
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
end
