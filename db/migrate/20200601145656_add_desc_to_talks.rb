class AddDescToTalks < ActiveRecord::Migration[5.2]
  def change
    add_column :talks, :description, :text
  end
end
