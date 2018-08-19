class LocationsController < ApplicationController
  include Response

  def show
    @location = Location.find(params[:id])
  end
end
