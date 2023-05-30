class Admin::CategoriesController < ApplicationController
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
				format.html { redirect_to admin_category_url }
				format.turbo_stream
			end
		else
			render :new, status: :unprocessable_entity
		end
	end

	def destroy
		@category = Category.find(params[:id])
		@category.destroy
		redirect_to admin_categories_path
	end
			
	def edit 
		@category = Category.find(params[:id])
	end
  
	def update
		@category = Category.find(params[:id])
		if @category.update(category_params)
				flash[:success] = "Edited successfully"
				render 'index'
		else
			flash[:alert] = @category.errors.full_messages
			render 'edit'
		end
	end
  
	def category_params
		params.require(:category).permit(:category_name)
	end
  
	# Authorization for category page
	def require_admin
		unless current_user.is? :admin
			flash[:alert] = 'You are not authorized to access this page.'
			redirect_to dashboard_index_path
		end
	end
end