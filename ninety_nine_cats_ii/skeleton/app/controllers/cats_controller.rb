class CatsController < ApplicationController

  before_action :redirect_if_not_owner, only: [:edit, :update]

  def index
    @cats = Cat.all
    render :index
  end

  def show
    @cat = Cat.find(params[:id])
    render :show
  end

  def new
    @cat = Cat.new
    render :new
  end

  def create
    @cat = Cat.new(cat_params)
    @cat.user_id = current_user.id if current_user
    if @cat.save
      redirect_to cat_url(@cat)
    else
      flash.now[:errors] = @cat.errors.full_messages
      render :new
    end
  end

  def edit
    @cat = Cat.find(params[:id])
    render :edit
  end

  def update
    @cat = Cat.find(params[:id])
    if @cat.update_attributes(cat_params)
      redirect_to cat_url(@cat)
    else
      flash.now[:errors] = @cat.errors.full_messages
      render :edit
    end
  end

  private

  def cat_params
    params.require(:cat)
      .permit(:age, :birth_date, :color, :description, :name, :sex)
  end

  def redirect_if_not_owner
    unless current_user && !current_user.cats.any?{ |cat| cat.id == params[:id] }
    # unless current_user && !current_user.cats.select('id').where('user_id=#{params[:id]}').empty?
    # unless current_user && current_user.cats.where('id = #{params[:id]}')
    # unless current_user && current_user.id == Cat.find(params[:id]).user_id
      flash.now[:errors] = "Must be logged in"
      redirect_to cats_url
    end
  end
end
