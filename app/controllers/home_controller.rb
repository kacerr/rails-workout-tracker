class HomeController < ApplicationController
	skip_before_action :require_login

	def index
		# we are going to list workouts stream
		# for start we just display all workouts, newest first
    @workouts = Workout.public_scope.order('date DESC')
		@groupworkouts = Workout
      .unscoped
      .includes(:user)
      .where(
  			"user_id in 
  				(select user_id from memberships where group_id in 
  						(select group_id from memberships where user_id=#{current_user.id} and show_in_groups_stream = 1)
  				)")
      .where("users.visibility>0")
      .order('date DESC') if (current_user) 
		@news = Article.all.order('updated_at DESC').limit(5)
    @excercises = Excercise.all
	end
end
