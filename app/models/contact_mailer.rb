class ContactMailer < ActionMailer::Base
  
  def contact_notification(contact_handler)
    
    @recipients  = "think.jackson@linslaundromat.com"
    @from        = contact_handler.email
    @subject     = "Contact form: #{contact_handler.subject}"
    
    @body[:contact_handler] = contact_handler
    
  end

end