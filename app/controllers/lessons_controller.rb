class LessonsController < ApplicationController
  allow_unauthenticated_access only: :show

  def show
    # Find the published course first
    @course = Course.published.find_by!(slug: params[:course_slug])

    # Find the lesson within this course
    @lesson = @course.lessons.find_by!(position: params[:position])

    # Simple access control - for now, authenticated users can access
    # Later we'll add subscription checks
    @can_access = authenticated?
  end
end
