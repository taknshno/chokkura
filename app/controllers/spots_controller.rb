class SpotsController < ApplicationController
  #before_action :set_spot, only: %i[show edit update destroy]

  def index
    @spots = Spot.all
  end

  def new
    if params[:back]
      @spot = Spot.new(spot_params)
    else
      @spot = Spot.new
    end
  end

  def confirm
    @spot = Spot.new(spot_params)
    # if @spot.invalid?
    #   flash[:danger] = "入力に誤りがあります"
    #   render :new
    # end
  end

  def create
    # @spot = current_user.spots.build(spot_params)
    @spot = Spot.new(spot_params)
    if params[:back]
      render :new
    else
      if @spot.save
        flash[:success] = "観光スポットを登録しました"
        redirect_to spots_path
      else
        flash[:danger] = "入力に誤りがあります"
        render :new
      end
    end
  end

  private

  def set_spot
    @spot = Spot.find(params[:id])
  end

  def spot_params
    params.require(:spot).permit(:name, :area, :address, :phone, :holiday,
       :sales_copy, :detail_description, :simple_description, :image, :image_cache)
  end
end
