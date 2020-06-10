class AddCategoryToTalks < ActiveRecord::Migration[5.2]
  def change
    add_reference :talks, :category, foreign_key: true
  end
end
