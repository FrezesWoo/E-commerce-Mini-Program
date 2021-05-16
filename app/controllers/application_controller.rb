class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!, :set_locale, :set_raven_context

  def check_admin
    return unless !current_user.is?('admin')
    redirect_to root_path, error: 'You are not allowed to access this part of the site'
  end

  def default_url_options
    { locale: I18n.locale }
  end

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def set_raven_context
    puts 'bob'
    # Raven.user_context(id: session[:current_user_id]) # or anything else in session
    # Raven.extra_context(params: params.to_unsafe_h, url: request.url)
  end

end
