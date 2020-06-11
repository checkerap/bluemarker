class Paper < ApplicationRecord
  belongs_to :user
  belongs_to :talk
  
  has_one_attached :document
  
  has_many :paper_files
  
  has_many :paper_authors, dependent: :delete_all
  has_many :authors, through: :paper_authors, :source => 'user'
end
