class SessionsController < ApplicationController


before_action :redirect_if_logged_in, only: :new
  def new
    @hide_login_link = true
    render :new
  end

  def create
    user = User.find_by_credentials(
      params[:user][:user_name],
      params[:user][:password]
    )

    if user
      log_in(user)
      redirect_to cats_url
    else
      @hide_login_link = true
      render :new
    end

  end

  def destroy
    log_out
    redirect_to cats_url
  end

end
