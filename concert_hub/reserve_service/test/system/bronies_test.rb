require "application_system_test_case"

class BroniesTest < ApplicationSystemTestCase
  setup do
    @brony = bronies(:one)
  end

  test "visiting the index" do
    visit bronies_url
    assert_selector "h1", text: "Bronies"
  end

  test "creating a Brony" do
    visit bronies_url
    click_on "New Brony"

    fill_in "Id ticket", with: @brony.id_ticket
    fill_in "Number brony", with: @brony.number_brony
    fill_in "Time broby", with: @brony.time_broby
    click_on "Create Brony"

    assert_text "Brony was successfully created"
    click_on "Back"
  end

  test "updating a Brony" do
    visit bronies_url
    click_on "Edit", match: :first

    fill_in "Id ticket", with: @brony.id_ticket
    fill_in "Number brony", with: @brony.number_brony
    fill_in "Time broby", with: @brony.time_broby
    click_on "Update Brony"

    assert_text "Brony was successfully updated"
    click_on "Back"
  end

  test "destroying a Brony" do
    visit bronies_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Brony was successfully destroyed"
  end
end
