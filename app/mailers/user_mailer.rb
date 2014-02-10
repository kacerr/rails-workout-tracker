class UserMailer < ActionMailer::Base
  default from: "workout.tracker.2014@gmail.com"

  def registration_confirmation(user)
  	@user = user
    mail(:to => user.alternative_email || user.email, :subject => "Registered")
  end

  def password_reset(user)
    @user = user
    mail :to => user.alternative_email || user.email, :subject => "Password Reset"
  end  
end
