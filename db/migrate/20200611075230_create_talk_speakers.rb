class CreateTalkSpeakers < ActiveRecord::Migration[5.2]
  def change
    create_table :talk_speakers do |t|
      t.references :talk, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
