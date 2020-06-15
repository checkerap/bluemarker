class Topic < ApplicationRecord
  belongs_to :message_board
  belongs_to :last_post, class_name: 'Post', optional: true
  
  has_many :posts, dependent: :delete_all
end
