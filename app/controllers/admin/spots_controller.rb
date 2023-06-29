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

    @spot[:phone] = "未掲載" if @spot[:phone].blank?
    @spot[:holiday] = "未掲載" if @spot[:holiday].blank?

    if @spot.invalid?
      flash[:danger] = t('flash.input_error')
      render :new
    end
  end

  def create
    @spot = Spot.new(spot_params)
    if params[:back]
      render :new
    else
      if @spot.save
        flash[:notice] = t('flash.registered_spot')
        redirect_to spots_path
      else
        flash[:danger] = t('flash.input_error')
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
      flash[:notice] = t('flash.updated_spot')
      redirect_to spots_path
    else
      render 'edit'
    end
  end

  def destroy
    if @spot.destroy
      flash[:notice] = t('flash.deleted_spot')
      redirect_to spots_path
    else
      render 'edit'
    end
  end

  private

  def set_spot
    @spot = Spot.find(params[:id])
  end

  def spot_params
    params.require(:spot).permit(:name, :area, :address, :phone, :holiday, :sales_copy,
      :detail_description, :simple_description, :images_cache, {images: []}, {tag_ids: []})
  end

  def if_not_admin
    unless current_user.admin? then
      flash[:danger] = t('flash.permission_denied')
      redirect_to spots_path
    end
  end
end
