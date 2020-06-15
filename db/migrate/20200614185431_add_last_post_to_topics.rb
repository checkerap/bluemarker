class AddLastPostToTopics < ActiveRecord::Migration[5.2]
  def change
    add_reference :topics, :last_post, foreign_key: { to_table: :posts }
  end
end
