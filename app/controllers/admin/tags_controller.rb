class Admin::TagsController < ApplicationController
  before_action :if_not_admin
  before_action :set_tag, only: %i[show edit update destroy]

  def index
    @tags = Tag.all
  end

  def new
    if params[:back]
      @tag = Tag.new(tag_params)
    else
      @tag = Tag.new
    end
  end

  def confirm
    @tag = Tag.new(tag_params)
    if @tag.invalid?
      flash[:danger] = I18n.t('flash.input_error')
      render :new
    end
  end

  def create
    @tag = Tag.new(tag_params)
    if params[:back]
      render :new
    else
      if @tag.save
        flash[:notice] = I18n.t('flash.created_tag')
        redirect_to admin_tags_path
      else
        flash[:danger] = I18n.t('flash.input_error')
        render :new
      end
    end
  end

  def edit
  end

  def update
    if @tag.update(tag_params)
      flash[:notice] = I18n.t('flash.edited_tag')
      redirect_to admin_tags_path
    else
      flash[:danger] = I18n.t('flash.edited_tag_failed')
      render :edit
    end
  end

  def destroy
    if @tag.destroy
      flash[:notice] = I18n.t('flash.deleted_tag')
      redirect_to admin_tags_path
    else
      flash[:danger] = I18n.t('flash.delete_tag_failed')
      redirect_to admin_tags_path
    end
  end

  private

  def set_tag
    @tag = Tag.find(params[:id])
  end

  def tag_params
    params.require(:tag).permit(:name)
  end

  def if_not_admin
    unless current_user.admin? then
      flash[:danger] = I18n.t('flash.permission_denied')
      redirect_to root_path
    end
  end

end
