ActionMailer::Base.smtp_settings = {
  :address              => "smtp.gmail.com",
  :port                 => 587,
  :domain               => "gmail.com",
  :user_name            => "workout.tracker.2014@gmail.com",
  :password             => "workout@gmail",
  :authentication       => "plain",
  :enable_starttls_auto => true
}


ActionMailer::Base.default_url_options[:host] = "localhost:3000"

require 'development_mail_interceptor' #add this line
Mail.register_interceptor(DevelopmentMailInterceptor) if Rails.env.development?
