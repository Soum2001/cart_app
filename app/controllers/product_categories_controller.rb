class ProductCategoriesController < ApplicationController
  def index
    @category = ProductCategory.all
  end

  def new
    @category = ProductCategory.new
  end

  def create
    @product_category = ProductCategory.new(category_params)
    if @product_category.save
      respond_to do |format|
        format.html { redirect_to product_categories_path }
        format.turbo_stream
      end
    else
      render :new, status: :unprocessable_entity
    end
  end
  
  def category_params
    params.require(:product_category).permit(:category_name)
  end

end
