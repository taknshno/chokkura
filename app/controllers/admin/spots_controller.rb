class Admin::SpotsController < ApplicationController
  before_action :if_not_admin
  before_action :set_spot, only: %i[show edit update destroy]

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
    if @spot.invalid?
      flash[:danger] = I18n.t('flash.input_error')
      render :new
    end
  end

  def create
    # @spot = current_user.spots.build(spot_params)
    @spot = Spot.new(spot_params)
    if params[:back]
      render :new
    else
      if @spot.save
        flash[:notice] = I18n.t('flash.registered_spot')
        redirect_to spots_path
      else
        flash[:danger] = I18n.t('flash.input_error')
        render :new
      end
    end
  end

  def show

  end

  def edit

  end

  def update
    if @spot.update(spot_params)
      flash[:notice] = I18n.t('flash.updated_spot')
      redirect_to spots_path
    else
      render 'edit'
    end
  end

  def destroy
    if @spot.destroy
      flash[:notice] = I18n.t('flash.deleted_spot')
      redirect_to spots_path
    else
      render 'edit'
    end
  end

  private

  def if_not_admin
    flash[:danger] = I18n.t('flash.permission_denied')
    redirect_to root_path unless current_user.admin?
  end

  def set_spot
    @spot = Spot.find(params[:id])
  end

  def spot_params
    params.require(:spot).permit(:name, :area, :address, :phone, :holiday,
        :sales_copy, :detail_description, :simple_description, :images_cache, {images: []})
  end
end
