class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_one_attached :image
  
  has_many :events
  
  has_many :event_speakers, dependent: :delete_all
  has_many :events_as_speaker, through: :event_speakers, :source => 'event'
  
  has_many :event_attendees, dependent: :delete_all
  has_many :events_as_attendee, through: :event_attendees, :source => 'event'
  
  has_many :talk_speakers, dependent: :delete_all
  has_many :talks, through: :talk_speakers
  
  has_many :papers, through: :talks
  
  validates :name, :email, :country, presence: true
  
  def title_organization 
    parts = []
    parts << self.title unless self.title.blank?
    parts << self.organization unless self.organization.blank?
    
    parts.join(', ')
  end
end
