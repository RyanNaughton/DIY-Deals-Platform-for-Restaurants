class UserMailer < ActionMailer::Base
  default from: "localdeals@simplebanana.com"

  def confirm_email(user)
   @user = user
   mail(:to => user.email, 
        :subject => "Thanks for signing up for Restaurant Deals!")
  end
 
end
