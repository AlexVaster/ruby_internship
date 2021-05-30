require "test_helper"

class BroniesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @brony = bronies(:one)
  end

  test "should get index" do
    get bronies_url
    assert_response :success
  end

  test "should get new" do
    get new_brony_url
    assert_response :success
  end

  test "should create brony" do
    assert_difference('Brony.count') do
      post bronies_url, params: { brony: { id_ticket: @brony.id_ticket, number_brony: @brony.number_brony, time_broby: @brony.time_broby } }
    end

    assert_redirected_to brony_url(Brony.last)
  end

  test "should show brony" do
    get brony_url(@brony)
    assert_response :success
  end

  test "should get edit" do
    get edit_brony_url(@brony)
    assert_response :success
  end

  test "should update brony" do
    patch brony_url(@brony), params: { brony: { id_ticket: @brony.id_ticket, number_brony: @brony.number_brony, time_broby: @brony.time_broby } }
    assert_redirected_to brony_url(@brony)
  end

  test "should destroy brony" do
    assert_difference('Brony.count', -1) do
      delete brony_url(@brony)
    end

    assert_redirected_to bronies_url
  end
end
