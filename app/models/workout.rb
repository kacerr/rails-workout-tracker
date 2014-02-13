class Workout < ActiveRecord::Base
	belongs_to :user
	has_many :workout_joins, foreign_key: "workout_id"
end
