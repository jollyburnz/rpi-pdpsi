class UsersController < ApplicationController
  # Be sure to include AuthenticationSystem in Application Controller instead
  
  # render new.rhtml
  def new
    @user = User.new
  end
 
  def create
    logout_keeping_session!
    @user = User.new(params[:user])
    success = @user && @user.save
    if success && @user.errors.empty?
            # Protects against session fixation attacks, causes request forgery
      # protection if visitor resubmits an earlier form using back
      # button. Uncomment if you understand the tradeoffs.
      # reset session
      self.current_user = @user # !! now logged in
      redirect_back_or_default('/')
      flash[:notice] = "Thanks for signing up!  We're sending you an email with your activation code."
    else
      flash[:error]  = "We couldn't set up that account, sorry.  Please try again, or contact an admin (link is above)."
      render :action => 'new'
    end
  end
  
  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
    respond_to do |format|
      if current_user.id != @user.id
        format.html {redirect_to forums_path}
      else
        format.html {render :action => "edit"}
      end
    end
  end
  
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to(@user, :notice => 'User was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def lost_password
    case request.method
    when :post
      @user = User.new
      @user.updating_email = false
      @user.attributes = params['user']
      if valid_for_attributes(@user, ["email","email_confirmation"])
        user = User.find_by_email(params[:user][:email])
        user.create_password_reset_code if user
        if !user
          flash[:notice] = "Email address is not found in our records."
        else
          flash[:notice] = "Reset code sent to #{params[:user][:email]}"
        end
        redirect_back_or_default('/lost_password')
      else
        flash[:error] = "Please enter a valid email address"
      end
    when :get
      @user = User.new
      @user.confirming_email = true
      @user.updating_email = false
    end
  end

  def reset_password
    @user = User.find_by_password_reset_code(params[:reset_code]) unless params[:reset_code].nil?
   if !@user
      flash[:error] = "Reset password token invalid, please contact support."
      redirect_to('/login')
      return
    else
      @user.crypted_password = nil
    end
    if request.post?
      if @user.update_attributes(:password => params[:user][:password], :password_confirmation => params[:user][:password_confirmation])
        #self.current_user = @user
       @user.delete_password_reset_code
        flash[:notice] = "Password updated successfully for #{@user.email} - You may now log in using your new password."
        redirect_back_or_default('/login')
      else
        render :action => :reset_password
      end
    end
  end
  
  # Might be a good addition to AR::Base
  def valid_for_attributes( model, attributes )
    unless model.valid?
      errors = model.errors
      our_errors = Array.new
      errors.each { |attr,error|
        if attributes.include? attr
          our_errors << [attr,error]
        end
      }
      errors.clear
      our_errors.each { |attr,error| errors.add(attr,error) }
      return false unless errors.empty?
    end
    return true
  end
  
end