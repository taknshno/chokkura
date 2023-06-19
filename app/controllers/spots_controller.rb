class SpotsController < ApplicationController

  def index
    @spots = Spot.all
  end

  def search
    @spots = Spot.all
    area = params[:area]
    tag_id = params[:tag_id]

    if area.present?
      @spots = @spots.area_search(area)
    end

    if tag_id.present?
      @spots = @spots.tag_search(tag_id.to_i)
    end

    #pagination
    #@spots = @spots.page(params[:page])
    render "index"
  end

  def show
    @spot = Spot.find(params[:id])
  end
end
