require "application_system_test_case"

class UsersTest < ApplicationSystemTestCase
  setup do
    @skip_login = true
    super
    @user = users(:one)
  end

  test "visiting the index" do
    login_as(@user)
    visit users_url
    assert_selector "h1", text: "Users"
  end

  test "should create user" do
    login_as(@user)
    visit users_url
    click_on "New user"

    fill_in "Name", with: @user.name
    fill_in "Password", with: "secret"
    fill_in "Password confirmation", with: "secret"
    click_on "Create User"

    assert_text "User was successfully created"
    click_on "Back"
  end

  test "should update User" do
    login_as(@user)
    visit users_url
    click_on "Edit this user", match: :first

    fill_in "Name", with: @user.name
    fill_in "Password", with: "secret"
    fill_in "Password confirmation", with: "secret"
    click_on "Update User"

    assert_text "User was successfully updated"
    click_on "Back"
  end

  test "should destroy User" do
    login_as(@user)
    visit user_url(@user)
    click_on "Destroy this user", match: :first

    assert_text "User was successfully destroyed"
  end
end