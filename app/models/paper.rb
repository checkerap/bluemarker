class Paper < ApplicationRecord
  belongs_to :user
  belongs_to :talk
  
  has_one_attached :document
end
