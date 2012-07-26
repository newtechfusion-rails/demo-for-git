class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user, :signed_in?
  before_filter :set_locale
  def set_locale
      @userlanguage = User.find_by_id(session[:user_id])
       if session[:user_id].present?
        I18n.locale = params[:locale] || @userlanguage.locale ||  I18n.default_locale
          if params[:locale] and @userlanguage
             @userlanguage.locale=params[:locale]
             @userlanguage.save
          end
       end
  end
  def current_user
		@current_user ||= User.find_by_id(session[:user_id]) if session[:user_id]
	end

	def signed_in?
		!!current_user
	end

	def current_user=(user)
		@current_user = user
		session[:user_id] = user.nil? ? user : user.id
	end

  def logged_in?
    return (session[:user_id].to_i > 0)
  end

end

private
def extract_locale_from_accept_language_header
  request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first
end