class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      flash[:notice] = "Logged in successfully"
      redirect_to user
    else
      flash.now[:alert] = "There was something wrong with your login details"
      render 'new'
    end
  end


  def destroy
    session[:user_id] = nil
    flash[:notice] = "Logged out"
    redirect_to root_path
  end



  def omniauth

user = User.from_omniauth(request.env['omniauth.auth'])
if user.valid?
      session[:user_id] = user.id 
      redirect_to user_path(user)
else 
   redirect_to '/login'
  end
end 
end 




