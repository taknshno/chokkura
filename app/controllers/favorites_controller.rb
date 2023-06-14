class FavoritesController < ApplicationController
  def create
    favorite = current_user.favorites.create(spot_id: params[:spot_id])
    flash[:notice] = t('flash.favorited_spot')
    redirect_to spots_path
  end

  def destroy
    favorite = current_user.favorites.find_by(id: params[:id]).destroy
    flash[:notice] = t('flash.removed_favorite_spot')
    redirect_to spots_path
  end
end
