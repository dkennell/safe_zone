class LocationsController < ApplicationController
  include Response

  def show
    @location = Location.find(params[:id])
  end

  def polygons
    @location = Location.find(params[:id])
    json_response(find_polygonal_data(@location.zipcode))
  end

  private

  def find_polygonal_data(zipcode)
    zipcode = zipcode.to_i
    file = File.read('app/assets/json/birmingham_polygons.json')
    data_hash = JSON.parse(file)
    zipcode_hash = {}
    # Find index of zipcode
    data_hash.dig('features').each do |full_hash|
      zipcode_hash = full_hash.dig('geometry').dig('coordinates').dig(0) if full_hash.dig('properties').dig('ZIPCODE') == zipcode
    end
    vals = {values: []}
    zipcode_hash.each do |combo|
      vals[:values] << {lat: combo[1], lng: combo[0]}
    end
    vals.to_json
  end
end
