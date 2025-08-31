class HomeController < ApplicationController
  allow_unauthenticated_access only: :show

  def show
    if authenticated?
      redirect_to dashboard_path
    end
  end
end
