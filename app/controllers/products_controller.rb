class ProductsController < ApplicationController
    def index
        @products = Product.page(params[:page]).per(10)
    end
    def search
        @searched_product = params[:search]
        @products = Product.where("name LIKE?","#{@searched_product}%")
    end
end
