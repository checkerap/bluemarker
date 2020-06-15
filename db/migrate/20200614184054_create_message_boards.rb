class CreateMessageBoards < ActiveRecord::Migration[5.2]
  def change
    create_table :message_boards do |t|
      t.boolean :is_private
      t.references :event, foreign_key: true
      t.string :title
      t.text :description

      t.timestamps
    end
  end
end
