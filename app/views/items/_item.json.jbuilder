json.extract! item, :id, :file_name, :attachment, :created_at, :updated_at
json.url item_url(item, format: :json)
