class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :checkbox_helper

  def checkbox_helper(rating)
    # try reading from params, the session, then default to true
    if params[:ratings] 
      params[:ratings].include?(rating)
    elsif session[:ratings]
      session[:ratings].include?(rating)
    else
      true
    end
  end

end
