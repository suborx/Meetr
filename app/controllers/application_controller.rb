class ApplicationController < ActionController::Base

  include InheritedResources::DSL

  protect_from_forgery
  before_filter :set_locale

  private

  def set_locale
    return unless request.env['HTTP_ACCEPT_LANGUAGE']
    accept_locale = request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first
    if params[:lang]
      session['session.language'] = params[:lang]
    end
    I18n.locale = session['session.language'] || accept_locale || 'en'
  end
end
