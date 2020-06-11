json.extract! paper, :id, :title, :description, :user_id, :talk_id, :created_at, :updated_at
json.url paper_url(paper, format: :json)
