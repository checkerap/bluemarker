class CreatePaperFiles < ActiveRecord::Migration[5.2]
  def change
    create_table :paper_files do |t|
      t.string :title
      t.references :paper, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
