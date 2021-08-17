class CitiesController < ApplicationController
  def index
  end

  def edit
    @city = City.find(params[:id])
  end

  def destroy
  end

  def update
  end
end
