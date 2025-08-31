# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

# Clear existing data in development
if Rails.env.development?
  puts "🧹 Clearing existing data..."
  VideoProgress.destroy_all
  Enrollment.destroy_all
  Lesson.destroy_all
  Course.destroy_all
  User.destroy_all
end

# Create test courses
puts "📚 Creating courses..."
rails_course = Course.create!(
  title: "Rails Fundamentals",
  description: "Learn the basics of Ruby on Rails development",
  slug: "rails-fundamentals", 
  price: 99.00,
  published: true
)

advanced_course = Course.create!(
  title: "Advanced Rails Patterns",
  description: "Master advanced Rails techniques and patterns",
  slug: "advanced-rails-patterns",
  price: 199.00, 
  published: true
)

# Add lessons to Rails course
puts "📖 Creating lessons..."
rails_course.lessons.create!([
  {
    title: "Introduction to MVC",
    description: "Understanding the Model-View-Controller pattern",
    position: 1,
    duration: 600, # 10 minutes
    video_id: "intro_mvc_123"
  },
  {
    title: "ActiveRecord Basics", 
    description: "Working with models and databases",
    position: 2,
    duration: 900, # 15 minutes
    video_id: "activerecord_456"
  },
  {
    title: "Routes and Controllers",
    description: "Handling HTTP requests in Rails",
    position: 3,
    duration: 1200, # 20 minutes  
    video_id: "routes_controllers_789"
  }
])

# Add lessons to Advanced course
advanced_course.lessons.create!([
  {
    title: "Service Objects",
    description: "Organizing business logic with service objects",
    position: 1,
    duration: 1800, # 30 minutes
    video_id: "service_objects_101"
  },
  {
    title: "Background Jobs",
    description: "Processing tasks asynchronously",
    position: 2,
    duration: 1500, # 25 minutes
    video_id: "background_jobs_202"
  }
])

# Create test users
puts "👥 Creating users..."
test_user = User.create!(
  email_address: "student@example.com",
  password: "securepassword123"
)

instructor_user = User.create!(
  email_address: "instructor@example.com", 
  password: "instructorpass123"
)

# Enroll users in courses
puts "📝 Creating enrollments..."
enrollment = test_user.enrollments.create!(
  course: rails_course,
  enrolled_at: Time.current,
  progress_percentage: 33.33
)

# Advanced course enrollment
test_user.enrollments.create!(
  course: advanced_course,
  enrolled_at: 2.days.ago,
  progress_percentage: 0
)

# Add some video progress
puts "🎥 Creating video progress..."
first_lesson = rails_course.lessons.first
test_user.video_progresses.create!(
  lesson: first_lesson,
  current_time: 600,
  duration: 600,
  completed: true,
  last_watched_at: 1.day.ago
)

# Partial progress on second lesson
second_lesson = rails_course.lessons.second
test_user.video_progresses.create!(
  lesson: second_lesson,
  current_time: 300,
  duration: 900,
  completed: false,
  last_watched_at: 2.hours.ago
)

puts "✅ Created #{Course.count} courses"
puts "✅ Created #{Lesson.count} lessons" 
puts "✅ Created #{User.count} users"
puts "✅ Created #{Enrollment.count} enrollments"
puts "✅ Created #{VideoProgress.count} video progress records"
puts "🎉 Seeding completed successfully!"
