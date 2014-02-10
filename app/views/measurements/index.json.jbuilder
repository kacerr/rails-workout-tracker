json.array!(@measurements) do |measurement|
  json.extract! measurement, :id, :name, :description, :datatype
  json.url measurement_url(measurement, format: :json)
end
