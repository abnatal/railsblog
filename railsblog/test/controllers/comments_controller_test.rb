require "test_helper"

class CommentsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  setup do
    @post_one = posts(:one)
    @post_two = posts(:two)
    @comment_one = comments(:one)
    @comment_two = comments(:two)
  end

  test "should destroy comment" do
    sign_in users(:one)

    assert_difference("Comment.count", -1) do
      delete post_comment_path(@post_one, @comment_one)
    end

    assert_redirected_to post_url(@post_one)
  end

  test "should NOT destroy another user comment" do
    sign_in users(:one)

    assert_difference("Comment.count", 0) do
      delete post_comment_path(@post_two, @comment_two)
    end

    assert_redirected_to root_path
  end

end
