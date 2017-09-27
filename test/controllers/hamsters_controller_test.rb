require 'test_helper'

class HamstersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @hamster = hamsters(:one)
  end

  test "should get index" do
    get hamsters_url, as: :json
    assert_response :success
  end

  test "should create hamster" do
    assert_difference('Hamster.count') do
      post hamsters_url, params: { hamster: { color: @hamster.color, name: @hamster.name, victory_points: @hamster.victory_points } }, as: :json
    end

    assert_response 201
  end

  test "should show hamster" do
    get hamster_url(@hamster), as: :json
    assert_response :success
  end

  test "should update hamster" do
    patch hamster_url(@hamster), params: { hamster: { color: @hamster.color, name: @hamster.name, victory_points: @hamster.victory_points } }, as: :json
    assert_response 200
  end

  test "should destroy hamster" do
    assert_difference('Hamster.count', -1) do
      delete hamster_url(@hamster), as: :json
    end

    assert_response 204
  end
end
