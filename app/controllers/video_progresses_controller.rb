class VideoProgressesController < ApplicationController
  # POST /courses/:course_slug/lessons/:position/video_progress
  def create
    set_course_and_lesson
    @progress = Current.user.video_progresses.create!(
      lesson: @lesson,
      current_time: params[:current_time],
      duration: params[:duration],
      completed: params[:completed]
    )
    head :ok
  end

  # PATCH /courses/:course_slug/lessons/:position/video_progress
  def update
    set_course_and_lesson
    @progress = Current.user.video_progresses.find_or_initialize_by(lesson: @lesson)
    @progress.update!(
      current_time: params[:current_time],
      duration: params[:duration],
      completed: params[:completed]
    )
    head :ok
  end

  private

  def set_course_and_lesson
    @course = Course.published.find_by!(slug: params[:course_slug])
    @lesson = @course.lessons.find_by!(position: params[:position])
  end
end