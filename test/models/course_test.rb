require "test_helper"

class CourseTest < ActiveSupport::TestCase
  test "should be valid with valid attributes" do
    course = Course.new(
      title: "Rails Fundamentals",
      description: "Learn Rails basics",
      price: 99.99,
      slug: "rails-fundamentals",
      published: true
    )
    assert course.valid?
  end

  test "should require title" do
    course = Course.new(slug: "test-course")
    assert_not course.valid?
    assert_includes course.errors[:title], "can't be blank"
  end

  test "should require slug" do
    course = Course.new(title: "Test Course")
    assert_not course.valid?
    assert_includes course.errors[:slug], "can't be blank"
  end

  test "should require unique slug" do
    existing_course = courses(:one)
    course = Course.new(
      title: "New Course",
      slug: existing_course.slug
    )
    assert_not course.valid?
    assert_includes course.errors[:slug], "has already been taken"
  end

  test "should accept positive prices" do
    course = Course.new(
      title: "Test Course",
      slug: "test-course",
      price: 10.00
    )
    assert course.valid?
  end

  test "should have many lessons ordered by position" do
    course = Course.create!(
      title: "Test Course for Ordering",
      description: "Testing lesson ordering",
      price: 29.99,
      slug: "test-course-ordering"
    )
    assert_respond_to course, :lessons

    # Create lessons with different positions
    lesson1 = course.lessons.create!(
      title: "First Lesson",
      description: "First lesson description",
      position: 2,
      duration: 600
    )
    lesson2 = course.lessons.create!(
      title: "Second Lesson",
      description: "Second lesson description",
      position: 1,
      duration: 600
    )

    # Should be ordered by position, not creation order
    assert_equal [lesson2, lesson1], course.lessons.to_a
  end

  test "should have many enrollments" do
    course = courses(:one)
    assert_respond_to course, :enrollments
  end

  test "should have many users through enrollments" do
    course = courses(:one)
    assert_respond_to course, :users
  end

  test "published scope should return only published courses" do
    # Create a published course
    published_course = Course.create!(
      title: "Published Course",
      description: "A published course",
      price: 49.99,
      slug: "published-course",
      published: true
    )

    # Create an unpublished course
    unpublished_course = Course.create!(
      title: "Unpublished Course",
      description: "An unpublished course",
      price: 29.99,
      slug: "unpublished-course",
      published: false
    )

    published_courses = Course.published
    assert_includes published_courses, published_course
    assert_not_includes published_courses, unpublished_course
  end

  test "to_param should return slug" do
    course = courses(:one)
    assert_equal course.slug, course.to_param
  end

  test "should destroy dependent lessons when course is destroyed" do
    course = Course.create!(
      title: "Course to Delete",
      description: "This course will be deleted",
      price: 19.99,
      slug: "course-to-delete"
    )

    lesson = course.lessons.create!(
      title: "Lesson in Course",
      description: "This lesson belongs to the course",
      position: 1,
      duration: 300
    )

    assert_difference "Lesson.count", -1 do
      course.destroy
    end
  end

  test "should destroy dependent enrollments when course is destroyed" do
    course = Course.create!(
      title: "Course with Enrollments",
      description: "This course has enrollments",
      price: 39.99,
      slug: "course-with-enrollments-test"
    )

    user = users(:one)
    enrollment = course.enrollments.create!(user: user)

    assert_difference "Enrollment.count", -1 do
      course.destroy
    end
  end

  test "should handle decimal prices correctly" do
    course = Course.new(
      title: "Decimal Price Course",
      description: "Testing decimal prices",
      price: 99.99,
      slug: "decimal-price-course"
    )
    assert course.valid?
    assert_equal 99.99, course.price
  end

  test "should handle zero price (free courses)" do
    course = Course.new(
      title: "Free Course",
      description: "This course is free",
      price: 0.00,
      slug: "free-course"
    )
    assert course.valid?
    assert_equal 0.00, course.price
  end
end
