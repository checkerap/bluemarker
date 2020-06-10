class AddVideosToTalks < ActiveRecord::Migration[5.2]
  def change
    add_column :talks, :live_video_link, :text
    add_column :talks, :recorded_video_link, :text
  end
end
