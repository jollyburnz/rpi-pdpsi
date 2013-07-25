require 'digest/sha1'

class User < ActiveRecord::Base
  include SavageBeast::UserInit
  include Authentication
  include Authentication::ByPassword
  include Authentication::ByCookieToken
  
  has_attached_file :avatar, :styles => { :thumb => "60x60#"},
  :url => "/avatars/:id/:style/:basename.:extension",
  :path => ":rails_root/public/avatars/:id/:style/:basename.:extension" 
  
  validates_attachment_presence :avatar  
  validates_attachment_size :avatar, :less_than => 5.megabytes  
  validates_attachment_content_type :avatar, :content_type => ['image/jpeg', 'image/png', 'image/gif']

  validates_presence_of     :login
  validates_length_of       :login,    :within => 3..40
  validates_uniqueness_of   :login
  validates_format_of       :login,    :with => Authentication.login_regex, :message => Authentication.bad_login_message

  validates_format_of       :name,     :with => Authentication.name_regex,  :message => Authentication.bad_name_message, :allow_nil => true
  validates_length_of       :name,     :maximum => 100

  validates_presence_of     :email,     :if => :confirming_email
  validates_length_of       :email,     :within => 6..100 #r@a.wk
  validates_uniqueness_of   :email,     :if => :updating_email?
  validates_confirmation_of :email,     :if => :confirming_email
  validates_format_of       :email,     :with => Authentication.email_regex, :message => Authentication.bad_email_message

  

  # HACK HACK HACK -- how to do attr_accessible from here?
  # prevents a user from submitting a crafted form that bypasses activation
  # anything else you want your user to change should be added here.
  attr_accessible :login, :email, :name, :password, :password_confirmation, :avatar, :email_confirmation
 
  attr_accessor :updating_email, :confirming_email  # allows us to control when email uniqueness and confirmation are validated (respectively)

  # Authenticates a user by their login name and unencrypted password.  Returns the user or nil.
  #
  # uff.  this is really an authorization, not authentication routine.  
  # We really need a Dispatch Chain here or something.
  # This will also let us return a human error message.
  #
  def self.authenticate(login, password)
    return nil if login.blank? || password.blank?
    u = find_by_login(login.downcase) # need to get the salt
    u && u.authenticated?(password) ? u : nil
  end

  def login=(value)
    write_attribute :login, (value ? value.downcase : nil)
  end

  def email=(value)
    write_attribute :email, (value ? value.downcase : nil)
  end
  
  def display_name
		login
	end
	
	def admin?
	  if login == 'jackson'
	    true
    else
      false
    end
  end
  
  
  def create_password_reset_code
    @password_reset = true
    self.password_reset_code = Digest::SHA1.hexdigest( Time.now.to_s.split(//).sort_by {rand}.join )
    self.save(false)
  end
  def password_recently_reset?
    @password_reset
  end 
  def delete_password_reset_code
    self.password_reset_code = nil
    self.save(false)
  end

protected
  def updating_email?
    # validate_uniqueness_of email unless specifically set to false
    if @updating_email == false
      return false
    else
      return true
    end
  end
  
end
