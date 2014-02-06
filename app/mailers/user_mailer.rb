class UserMailer < ActionMailer::Base
  default from: "workout.tracker.2014@gmail.com"

  def registration_confirmation(user)
  	@user = user
    mail(:to => user.email, :subject => "Registered")
  end  
end
