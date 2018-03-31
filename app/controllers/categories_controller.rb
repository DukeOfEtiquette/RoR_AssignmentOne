class CategoriesController < ApplicationController
  
  before_action :require_admin, only: [:new, :create]
  
  def index
    @categories = Category.paginate(page: params[:page], per_page: 4)
  end
  
  def new
    @category = Category.new
  end
  
  def create
    @category = Category.new(category_params)
    
    if @category.save
      flash[:success] = "New category successfully created!"
      redirect_to categories_path
    else
      render 'new'
    end
  end
  
  def edit
    @category = Category.find(params[:id])
  end
  
  def update
    @category = Category.find(paras[:id])
    if @category.update(category_params)
      falsh[:success] = "Category update successful."
      redirect_to category_path(@category)
    else
      render 'edit'
    end
  end
  
  def show
    @category = Category.find(params[:id])
    @category_articles = @category.articles.paginate(page: params[:page], per_page: 5)
  end
  
  private
  	def category_params
      params.require(:category).permit(:name)
    end
  
  	def require_admin
      if !logged_in? || (logged_in? && !current_user.admin?)
        flash[:danger] = "Only admins can perform that action."
        redirect_to categories_path
      end
    end
  
end