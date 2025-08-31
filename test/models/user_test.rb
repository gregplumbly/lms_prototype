require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "should be valid with valid attributes" do
    user = User.new(
      email_address: "test@example.com",
      password: "password1234" # 12+ characters required
    )
    assert user.valid?
  end

  test "should require email_address" do
    user = User.new(password: "password1234")
    assert_not user.valid?
    assert_includes user.errors[:email_address], "can't be blank"
  end

  test "should require unique email_address" do
    existing_user = users(:one) # Using fixture
    user = User.new(
      email_address: existing_user.email_address,
      password: "password1234"
    )
    assert_not user.valid?
    assert_includes user.errors[:email_address], "has already been taken"
  end

  test "should require password" do
    user = User.new(email_address: "test@example.com")
    assert_not user.valid?
    assert_includes user.errors[:password], "can't be blank"
  end

  test "should authenticate with correct password" do
    user = users(:one)
    assert user.authenticate("password")
  end

  test "should not authenticate with incorrect password" do
    user = users(:one)
    assert_not user.authenticate("wrongpassword")
  end

  test "should have many enrollments" do
    user = users(:one)
    assert_respond_to user, :enrollments
  end

  test "should have many video_progresses" do
    user = users(:one)
    assert_respond_to user, :video_progresses
  end
end
