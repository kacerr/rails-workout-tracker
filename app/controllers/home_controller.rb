class HomeController < ApplicationController
	skip_before_action :require_login
	def index
		# we are going to list workouts stream
		# for start we just display all workouts, newest first
		@workouts = Workout.all.order('date DESC')
	end
end
