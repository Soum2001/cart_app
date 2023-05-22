class ProductsController < ApplicationController
  before_action :set_category_id, only:[:index]

  def index
    @category_id = params[:category_id]
    if @category_id.present?
      @products =  Product.joins(:category_products).where(category_products:{category_id: @category_id})
      # @products     =  @product_data.page(params[:page]).per(10)
    else
      @products = Product.page(params[:page]).per(10)
    end

    if params[:search].present?
      if @category_id.blank?
        @searched_product = params[:search]
        @products = Product.where("name LIKE?","%#{@searched_product}%")
      else
        @searched_product = params[:search]
        @products = Product.joins(category_products: :category).where('products.name LIKE?',"%#{@searched_product}%").where(category_products:{category_id: @category_id})
      end
    end
  end

  private
  def set_category_id
    @category_id = params[:category_id]
  end
end
