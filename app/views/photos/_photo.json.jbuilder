json.extract! photo, :id, :name, :shooting_date, :description, :created_at, :updated_at
json.url photo_url(photo, format: :json)
