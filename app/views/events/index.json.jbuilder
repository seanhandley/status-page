json.array!(@events) do |event|
  json.extract! event, :id, :title, :content, :event_date, :updated_at, :resolved_at, :resolved, :status_id
  json.url event_url(event, format: :json)
end
