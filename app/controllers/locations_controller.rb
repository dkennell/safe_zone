class LocationsController < ApplicationController
  def show
    @location = Location.find_by(params[:id])
  end
end
