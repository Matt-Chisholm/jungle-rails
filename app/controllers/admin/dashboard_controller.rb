class Admin::DashboardController < ApplicationController
  http_basic_authenticate_with name: ENV['HTTP_USER'], password: ENV['HTTP_PW']
  def show
    @products = Product.order(id: :desc).all
    @categories = Category.all
  end
end
