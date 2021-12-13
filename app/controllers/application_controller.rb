class ApplicationController < ActionController::Base
  before_action :require_login

  helper_method :current_user

  private

  def current_user
    @_current_user ||= session[:current_user_id] && User.find_by_id(session[:current_user_id])
  end

  def log_in(user)
    session[:current_user_id] = user.id
    @_current_user = user
  end

  def logged_in?
    !!session[:current_user_id]
  end

  def log_out
    session.delete(:current_user_id)
    @_current_user = nil
  end

  def require_login
    unless logged_in?
      response.status = 401
      redirect_to '/login'
    end
  end
end
