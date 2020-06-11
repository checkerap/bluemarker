class Talk < ApplicationRecord
  belongs_to :user
  belongs_to :event
  belongs_to :category
  
  has_many :papers
  
  has_many :talk_speakers, dependent: :delete_all
  has_many :speakers, through: :talk_speakers, :source => 'user'
end
