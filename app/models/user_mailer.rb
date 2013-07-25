class UserMailer < ActionMailer::Base
  def password_reset_notification(user)
    setup_email(user)
    @subject    = 'Link to reset your password'
    @body[:url]  = "http://rpi-pdpsi.linslaundromat.com/reset_password/#{user.password_reset_code}"
    @login = "#{user.login}"
  end
  
  protected
    def setup_email(user)
      @recipients  = "#{user.email}"
      @from        = "think.jackson@linslaundromat.com"
      @sent_on     = Time.now
    end
end