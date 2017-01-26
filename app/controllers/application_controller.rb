class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionHelper

  before_action :set_locale

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def render_404
    respond_to do |format|
      format.html {
        render :file => "#{Rails.root}/public/404",
               :layout => false,
               :status => :not_found }
      format.xml  { head :not_found }
      format.any  { head :not_found }
    end
  end

  def render_403
    respond_to do |format|
      format.html {
        render :file => "#{Rails.root}/public/403",
               :layout => false,
               :status => :forbidden }
      format.xml  { head :not_found }
      format.any  { head :not_found }
    end
  end
end
