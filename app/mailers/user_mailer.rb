class UserMailer < ActionMailer::Base
  default from: "workout.tracker.2014@gmail.com"

  def registration_confirmation(user)
  	@user = user
  	if user.alternative_email && user.alternative_email.match(/[a-zA-Z0-9._%]@(?:[a-zA-Z0-9]\.)[a-zA-Z]{2,4}/)
  		to = user.alternative_email 
  	else
  		to = user.email
  	end
    mail(:to => to, :subject => "Registered")
  end

  def password_reset(user)
    @user = user
  	if user.alternative_email && user.alternative_email.match(/[a-zA-Z0-9._%]@(?:[a-zA-Z0-9]\.)[a-zA-Z]{2,4}/)
  		to = user.alternative_email 
  	else
  		to = user.email
  	end
    mail :to => to, :subject => "Password Reset"
  end  
end
