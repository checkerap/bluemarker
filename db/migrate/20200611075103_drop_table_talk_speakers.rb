class DropTableTalkSpeakers < ActiveRecord::Migration[5.2]
  def change
    drop_table :talk_speakers
  end
end
