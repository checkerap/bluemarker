class Post < ApplicationRecord
  belongs_to :user 
  belongs_to :topic 
  
  belongs_to :post, class_name: 'Post', optional: true
  has_many :replies, class_name: 'Post', dependent: :nullify
  
  paginates_per 5
end
