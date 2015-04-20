class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session
  respond_to :json

  before_action :use_json_locale_for_xhr
  around_action :chewy_atomic

  def chewy_atomic &block
    Chewy.strategy(:atomic, &block)
  end

  # This is kinda hack. Can be reworked in Rails 5
  # but the sollution is also will not be great
  # for the moment.
  def use_json_locale_for_xhr
    I18n.locale = 'json' if request.xhr?
  end
end
