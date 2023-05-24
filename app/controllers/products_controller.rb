class ProductsController < ApplicationController
  before_action :set_category_id, only:[:index]

  def index
    @category_id = params[:category_id]
    @role = current_user.roles.find_by_role("seller")
    if @category_id.present?
      @products =  Product.joins(:category_products).where(category_products:{category_id: @category_id})
      if !@role.nil?
        @products =  @products.where.not(products: {user_id: current_user.id})
      end
      # @products     =  @product_data.page(params[:page]).per(10)
    else
      @products = Product.page(params[:page]).per(10)
      if !@role.nil?
        @products = @products.where.not(user_id: current_user.id)
      end
    end

    if params[:search].present?
      @searched_product = params[:search]
      if @category_id.blank?
        @products = Product.where("name LIKE?","%#{@searched_product}%")
        if !@role.nil?
          @products = Product.where("name LIKE?","%#{@searched_product}%").where.not(user_id: current_user.id)
        end
      else
        @products = Product.joins(category_products: :category).where('products.name LIKE?',"%#{@searched_product}%").where(category_products:{category_id: @category_id})
        if !@role.nil?
          @products = Product.joins(category_products: :category).where('products.name LIKE?',"%#{@searched_product}%").where(category_products:{category_id: @category_id}).where.not(products: {user_id: current_user.id})
        end
      end
    end
  end

  def new
    @product = Product.new
    authorize! :new, @product
  end

  def create
    @product = Product.create(name: params[:product][:name], price: params[:product][:price],user_id: current_user.id)
    @categories = params[:category]
    @categories.each do |category|
      @product.category_products.create(category_id: category)
    end
  end

  private
  def set_category_id
    @category_id = params[:category_id]
  end
end
