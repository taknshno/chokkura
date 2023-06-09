class SpotsController < ApplicationController
  before_action :set_spot, only: %i[show edit update destroy]

  def index
    @spots = Spot.all
  end

  def new

  end

  def create

  end

  private

  def set_picture
    @spot = Spot.find(params[:id])
  end

  def spot_params
    params.require(:spot).permit(:name, :area, :address, :phone, :holiday, :sales_copy,
                                  :detail_description, :simple_description, images: [])
  end
end
