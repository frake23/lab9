class SessionController < ApplicationController
  skip_before_action :require_login, only: [:create, :login]

  def login
    if logged_in?
      redirect_to '/'
    end
  end

  def create
    p params
    user = User.find_by_username(params[:username])
    if user&.authenticate(params[:password])
      log_in user
      redirect_to '/'
    else
      redirect_to '/login', flash: {alert: user.nil? ? 'Пользователь с таким именем не существует' : 'Неверный пароль'}
    end
  end

  def destroy
    log_out
    redirect_to '/login'
  end
end
