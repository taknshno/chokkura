class SpotsController < ApplicationController

  def index
    @spots = Spot.all
  end

  def search
    @spots = Spot.all
    key_tag_id = params[:key_tag_id]

    if key_tag_id.present?
      @spots = @spots.tag_search(key_tag_id.to_i)
    end

    #pagination
    #@spots = @spots.page(params[:page])
    render "index"
  end

  def show
    @spot = Spot.find(params[:id])
  end
end
