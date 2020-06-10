class AddVideoToEvents < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :video, :text
  end
end
