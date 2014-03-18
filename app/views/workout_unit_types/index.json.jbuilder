json.array!(@workout_unit_types) do |workout_unit_type|
  json.extract! workout_unit_type, :id, :name, :category, :difficulty, :description, :icon
  json.url workout_unit_type_url(workout_unit_type, format: :json)
end
