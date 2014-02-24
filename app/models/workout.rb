class Workout < ActiveRecord::Base
	belongs_to :user
	has_many :workout_joins, foreign_key: "workout_id"

	scope :public_scope , -> { includes(:user).where("users.visibility>1").order('date DESC')} 

end
