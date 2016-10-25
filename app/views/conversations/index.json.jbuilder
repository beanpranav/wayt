json.array!(@conversations) do |conversation|
  json.extract! conversation, :id, :subject, :source_author, :source_link, :source_content, :slug, :user_id
  json.url conversation_url(conversation, format: :json)
end
