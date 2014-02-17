class HomeController < ApplicationController
	skip_before_action :require_login

	def index
		# we are going to list workouts stream
		# for start we just display all workouts, newest first
		@workouts = Workout.all.order('date DESC')
		@groupworkouts = Workout.where(
			"user_id in 
				(select user_id from memberships where group_id in 
						(select group_id from memberships where user_id=#{current_user.id} and show_in_groups_stream = 1)
				)").order('date DESC') if (current_user) 
	end
end
