class CreatePaperAuthors < ActiveRecord::Migration[5.2]
  def change
    create_table :paper_authors do |t|
      t.references :paper, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
