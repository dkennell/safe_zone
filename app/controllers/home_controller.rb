class HomeController < ApplicationController
  def index
    if params[:zipcode].present?
      location = Location.find_by(zipcode: params[:zipcode].to_i)
      raise ActionController::RoutingError.new('Not Found') unless location.present?
      redirect_to(url_for(
        :controller => 'locations',
        :action => 'show',
        :id => location.id
      ))
    elsif params[:lat] && params[:lng]
      location = Location.find_by(zipcode: fetch_zipcode.to_i)
      raise ActionController::RoutingError.new('Not Found') unless location.present?
      redirect_to(url_for(
        :controller => 'locations',
        :action => 'show',
        :id => location.id
      ))
    else
    end
  end

  def how_to_help
  end

  def fetch_zipcode
    lat = params[:lat]
    lng = params[:lng]
    Geocoder.search([lat, lng]).first.postal_code
  end

  def info; end
end
