json.array!(@profiles) do |profile|
  json.extract! profile, :id, :birth_date, :country, :city, :bio, :height, :weight
  json.url profile_url(profile, format: :json)
end
