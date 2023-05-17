class ProductsController < ApplicationController
    def index
        category_id = params[:category_id]
        if category_id.present?
            @products =  Product.joins(:product_category_with_products).where(product_category_with_products:{product_category_id: params[:category_id]})
           # @products     =  @product_data.page(params[:page]).per(10)
        else
            @products = Product.page(params[:page]).per(10)
        end

        if params[:search].present?
            @searched_product = params[:search]
            @products = Product.where("name LIKE?","#{@searched_product}%")
        end
    end
    # def search
    #     @searched_product = params[:search]
    #     @products = Product.where("name LIKE?","#{@searched_product}%")
    #     binding.break
    # end
end
