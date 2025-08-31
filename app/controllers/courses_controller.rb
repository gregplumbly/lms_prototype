class CoursesController < ApplicationController
  allow_unauthenticated_access only: %i[index show]

  def index
    @courses = Course.published.order(created_at: :desc)
  end

  def show
    @course = Course.published.find_by!(slug: params[:slug])
    # Only published courses can be found!
  end
end
