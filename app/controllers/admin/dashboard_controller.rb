class Admin::DashboardController < ApplicationController
  http_basic_authenticate_with name: ENV['HTTP_USER'], password: ENV['HTTP_PW']
  def show
  end
end
