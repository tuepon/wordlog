class ApplicationController < ActionController::Base
  include Pagy::Backend
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!
  before_action :store_user_location!, if: :storable_location?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[username full_name])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[username full_name profile_pic])
  end

  def store_user_location!
    # 保存する条件: GETリクエスト、HTMLフォーマット、ログインしていない
    store_location_for(:user, request.fullpath)
  end

  def storable_location?
    request.get? && is_navigational_format? && !devise_controller? && !request.xhr?
  end
end
