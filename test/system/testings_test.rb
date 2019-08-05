require "application_system_test_case"

class TestingsTest < ApplicationSystemTestCase
  setup do
    @testing = testings(:one)
  end

  test "visiting the index" do
    visit testings_url
    assert_selector "h1", text: "Testings"
  end

  test "creating a Testing" do
    visit testings_url
    click_on "New Testing"

    fill_in "Name", with: @testing.name
    click_on "Create Testing"

    assert_text "Testing was successfully created"
    click_on "Back"
  end

  test "updating a Testing" do
    visit testings_url
    click_on "Edit", match: :first

    fill_in "Name", with: @testing.name
    click_on "Update Testing"

    assert_text "Testing was successfully updated"
    click_on "Back"
  end

  test "destroying a Testing" do
    visit testings_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Testing was successfully destroyed"
  end
end
