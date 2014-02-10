json.array!(@excercises) do |excercise|
  json.extract! excercise, :id, :name, :description, :url
  json.url excercise_url(excercise, format: :json)
end
