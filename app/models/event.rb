class Event < ApplicationRecord
  belongs_to :user
  belongs_to :category
  resourcify
  
  has_one_attached :image
  
  has_many :talks
  
  has_many :event_speakers, dependent: :delete_all
  has_many :speakers, through: :event_speakers, :source => 'user'
  
  has_many :event_attendees, dependent: :delete_all
  has_many :attendees, through: :event_attendees, :source => 'user'
end
