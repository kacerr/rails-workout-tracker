json.array!(@workouts) do |workout|
  json.extract! workout, :id, :title, :content, :user_id
  json.url workout_url(workout, format: :json)
end
