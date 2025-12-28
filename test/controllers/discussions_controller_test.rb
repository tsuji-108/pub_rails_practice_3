require "test_helper"

class DiscussionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @discussion = discussions(:one)
  end

  test "should get index" do
    get discussions_url, as: :json
    assert_response :success
  end

  test "should create discussion" do
    assert_difference("Discussion.count") do
      post discussions_url, params: { discussion: { board_id: @discussion.board_id, description: @discussion.description, title: @discussion.title, user_id: @discussion.user_id } }, as: :json
    end

    assert_response :created
  end

  test "should show discussion" do
    get discussion_url(@discussion), as: :json
    assert_response :success
  end

  test "should update discussion" do
    patch discussion_url(@discussion), params: { discussion: { board_id: @discussion.board_id, description: @discussion.description, title: @discussion.title, user_id: @discussion.user_id } }, as: :json
    assert_response :success
  end

  test "should destroy discussion" do
    assert_difference("Discussion.count", -1) do
      delete discussion_url(@discussion), as: :json
    end

    assert_response :no_content
  end
end
