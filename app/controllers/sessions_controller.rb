class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by email: params[:session][:email].downcase
    
    if user&.authenticate params[:session][:password]
      login user
      flash[:success] = t ".success"
      params[:session][:remember_me] == "1" ? remember(user) : forget(user)
      redirect_to root_path
    else
      flash[:danger] = t ".danger"
      render :new
    end
  end

  def destroy
    logout if logged_in?
    redirect_to root_path
  end
end
