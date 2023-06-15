class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @favorites = current_user.favorites
  end
end
