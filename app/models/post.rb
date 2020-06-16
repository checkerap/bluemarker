class Post < ApplicationRecord
  belongs_to :user 
  belongs_to :topic 
  
  paginates_per 5
end
