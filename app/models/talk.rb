class Talk < ApplicationRecord
  belongs_to :user
  belongs_to :event
  belongs_to :category
  
  has_many :papers
  
  def speakers
    User.with_role :talk_speaker, self
  end
end
