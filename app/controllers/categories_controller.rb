class CategoriesController < ApplicationController
  before_action :require_admin

  def index
    @category = Category.all
  end
    
  def new
    @category = Category.new
  end
    
  def create
    @category = Category.new(category_params)
    if @category.save
      respond_to do |format|
        format.html { redirect_to categories_path }
        format.turbo_stream
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy
    redirect_to categories_path
  end
      
  def edit 
    @category = Category.find(params[:id])
  end

  def update
    @category_update = Category.where(id: params[:id]).update(category_name: params[:category_name])
    redirect_to categories_path
  end

  def category_params
    params.require(:category).permit(:category_name)
  end

  def require_admin
    unless current_user.is? :admin
      flash[:alert] = 'You are not authorized to access this page.'
      redirect_to dashboard_index_path
    end
  end
end
