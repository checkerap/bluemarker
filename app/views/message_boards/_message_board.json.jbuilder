json.extract! message_board, :id, :is_private, :event_id, :title, :description, :created_at, :updated_at
json.url message_board_url(message_board, format: :json)
