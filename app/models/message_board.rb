class MessageBoard < ApplicationRecord
  belongs_to :event, optional: true
  has_many :topics, dependent: :delete_all
end
