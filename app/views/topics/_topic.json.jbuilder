json.extract! topic, :id, :title, :description, :message_board_id_id, :created_at, :updated_at
json.url topic_url(topic, format: :json)
