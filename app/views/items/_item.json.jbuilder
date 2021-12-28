json.extract! item, :id, :filename, :attachment, :created_at, :updated_at
json.url item_url(item, format: :json)
