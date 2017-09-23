require 'test_helper'

class HampstersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @hampster = hampsters(:one)
  end

  test "should get index" do
    get hampsters_url, as: :json
    assert_response :success
  end

  test "should create hampster" do
    assert_difference('Hampster.count') do
      post hampsters_url, params: { hampster: { color: @hampster.color, name: @hampster.name, victory_points: @hampster.victory_points } }, as: :json
    end

    assert_response 201
  end

  test "should show hampster" do
    get hampster_url(@hampster), as: :json
    assert_response :success
  end

  test "should update hampster" do
    patch hampster_url(@hampster), params: { hampster: { color: @hampster.color, name: @hampster.name, victory_points: @hampster.victory_points } }, as: :json
    assert_response 200
  end

  test "should destroy hampster" do
    assert_difference('Hampster.count', -1) do
      delete hampster_url(@hampster), as: :json
    end

    assert_response 204
  end
end
