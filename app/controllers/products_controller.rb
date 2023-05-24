class ProductsController < ApplicationController
  before_action :set_category_id, only:[:index]
  before_action :set_role, only:[:index, :new]

  def index
    if @category_id.present?
      @products = Product.page(params[:page]).per(10).joins(:category_products).where(category_products: { category_id: @category_id })
      # @products =  Product.joins(:category_products).where(category_products:{category_id: @category_id}).page(params[:page]).per(10)
      if !@role.nil?
        @products =  @products.where.not(products: {user_id: current_user.id}).page(params[:page]).per(10)
      end
      # @products = @product_data.page(params[:page]).per(10)
    else
      @products = Product.page(params[:page]).per(10)
      if !@role.nil?
        @products = @products.where.not(user_id: current_user.id)
      end
    end

    if params[:search].present?
      @searched_product = params[:search]
      if @category_id.blank?
        @products = Product.page(params[:page]).per(10).where("name LIKE?","%#{@searched_product}%")
        if !@role.nil?
          @products = @products.where.not(user_id: current_user.id)
        end
      else
        @products = Product.page(params[:page]).per(10).joins(category_products: :category).where('products.name LIKE?',"%#{@searched_product}%").where(category_products:{category_id: @category_id})
        if !@role.nil?
          @products = @products.where.not(products: {user_id: current_user.id})
        end
      end
    end
  end

  def new
    @product = Product.new
    if @role.nil?
      authorize! :new, @product
    end
  end

  def create
    @product = Product.create(name: params[:product][:name], price: params[:product][:price],user_id: current_user.id)
    @categories = params[:category]
    @categories.each do |category|
      @product.category_products.create(category_id: category)
    end
    redirect_to products_path
  end

  private
  def set_category_id
    @category_id = params[:category_id]
  end

  def set_role
    @role = current_user.roles.find_by_role("seller")
  end
end
