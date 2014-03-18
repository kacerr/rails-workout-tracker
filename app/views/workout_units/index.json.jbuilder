json.array!(@workout_units) do |workout_unit|
  json.extract! workout_unit, :id, :date, :workout_unit_type_id
  json.url workout_unit_url(workout_unit, format: :json)
end
