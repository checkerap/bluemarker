class TalkSpeaker < ApplicationRecord
  belongs_to :talk
  belongs_to :user
end
