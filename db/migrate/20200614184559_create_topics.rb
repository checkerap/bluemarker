class CreateTopics < ActiveRecord::Migration[5.2]
  def change
    create_table :topics do |t|
      t.string :title
      t.text :description
      t.references :message_board_id, foreign_key: true

      t.timestamps
    end
  end
end
