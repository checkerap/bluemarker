class AddVidelUrlToPaperLink < ActiveRecord::Migration[5.2]
  def change
    add_column :paper_files, :video_url, :text
  end
end
