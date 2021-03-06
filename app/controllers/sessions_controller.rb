class SessionsController < ApplicationController
  def index
  end

  def new
  end

  def show
  end

  def create
  	user = User.find_by_email(params[:email])
    # If the user exists AND the password entered is correct.
    if user && user.authenticate(params[:password])
      user.ip = request.remote_ip
      # Save the user id inside the browser cookie. This is how we keep the user 
      # logged in when they navigate around our website.
      session[:user_id] = user.id
      loc = Location.new(address: request.ip)
      user.update_attributes(longitude: loc.longitude, latitude: loc.latitude)
      redirect_to '/locations/new'
    else
    # If user's login doesn't work, send them back to the login form.
      redirect_to '/login'
    end
  end

  def destroy
  	session[:user_id] = nil
    redirect_to '/login'
  end

end
