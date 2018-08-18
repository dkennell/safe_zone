class HomeController < ApplicationController
  def index
    if params[:zipcode].present?
      redirect_to(url_for(
        :controller => 'locations',
        :action => 'show',
        :id => Location.find_by(zipcode: params[:zipcode].to_i).id
      ))
    elsif params[:lat] && params[:lng]
      redirect_to(url_for(
        :controller => 'locations',
        :action => 'show',
        :id => Location.find_by(zipcode: fetch_zipcode.to_i).id
      ))
    else
    end
  end

  def fetch_zipcode
    lat = params[:lat]
    lng = params[:lng]
    Geocoder.search([lat, lng]).first.postal_code
  end
end
