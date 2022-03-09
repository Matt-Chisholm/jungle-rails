class Admin::CategoriesController < ApplicationController

  def index
    @categories = Category.order(name: :asc).all
  end
  
  def new
  end

  def create
  end

  def category_params
    params.require(:category).permit(:name)
  end
end
