class DashboardController < ApplicationController
  def index
    @courses = Course.published.order(created_at: :desc)
  end
end
