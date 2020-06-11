class PaperFile < ApplicationRecord
  belongs_to :paper
  belongs_to :user
  
  has_one_attached :document
end
