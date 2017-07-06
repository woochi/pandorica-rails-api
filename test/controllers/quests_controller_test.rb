require 'test_helper'

class QuestsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @quest = quests(:one)
  end

  test "should get index" do
    get quests_url, as: :json
    assert_response :success
  end

  test "should create quest" do
    assert_difference('Quest.count') do
      post quests_url, params: { quest: { description: @quest.description, name: @quest.name, points: @quest.points, published: @quest.published } }, as: :json
    end

    assert_response 201
  end

  test "should show quest" do
    get quest_url(@quest), as: :json
    assert_response :success
  end

  test "should update quest" do
    patch quest_url(@quest), params: { quest: { description: @quest.description, name: @quest.name, points: @quest.points, published: @quest.published } }, as: :json
    assert_response 200
  end

  test "should destroy quest" do
    assert_difference('Quest.count', -1) do
      delete quest_url(@quest), as: :json
    end

    assert_response 204
  end
end
