class Event < ApplicationRecord
  belongs_to :user
  belongs_to :category
  resourcify
  
  has_one_attached :image
  
  has_many :talks
end
