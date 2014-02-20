json.array!(@user_measurements) do |user_measurement|
  json.extract! user_measurement, :id, :user_id, :measurement_id, :value, :value_string, :note
  json.url user_measurement_url(user_measurement, format: :json)
end
