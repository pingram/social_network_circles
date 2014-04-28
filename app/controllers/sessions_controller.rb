class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(email: params[:user][:email])
    if @user && @user.is_password?(params[:user][:password])
      sign_in!(@user)
      redirect_to posts_url
    else
      flash.now[:errors] = ["Invalid username or password"]
      render :new
    end
  end

  def destroy
    sign_out!
    redirect_to new_session_url
  end
end
