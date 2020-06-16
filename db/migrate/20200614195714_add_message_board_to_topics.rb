class AddMessageBoardToTopics < ActiveRecord::Migration[5.2]
  def change
    add_reference :topics, :message_board, foreign_key: true
    remove_reference :topics, :message_board_id, foreign_key: true
  end
end
