require 'test_helper'

class MessageBoardsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @message_board = message_boards(:one)
  end

  test "should get index" do
    get message_boards_url
    assert_response :success
  end

  test "should get new" do
    get new_message_board_url
    assert_response :success
  end

  test "should create message_board" do
    assert_difference('MessageBoard.count') do
      post message_boards_url, params: { message_board: { description: @message_board.description, event_id: @message_board.event_id, is_private: @message_board.is_private, title: @message_board.title } }
    end

    assert_redirected_to message_board_url(MessageBoard.last)
  end

  test "should show message_board" do
    get message_board_url(@message_board)
    assert_response :success
  end

  test "should get edit" do
    get edit_message_board_url(@message_board)
    assert_response :success
  end

  test "should update message_board" do
    patch message_board_url(@message_board), params: { message_board: { description: @message_board.description, event_id: @message_board.event_id, is_private: @message_board.is_private, title: @message_board.title } }
    assert_redirected_to message_board_url(@message_board)
  end

  test "should destroy message_board" do
    assert_difference('MessageBoard.count', -1) do
      delete message_board_url(@message_board)
    end

    assert_redirected_to message_boards_url
  end
end
