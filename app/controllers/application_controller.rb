class ApplicationController < ActionController::Base
  protect_from_forgery

  include UrlHelper
  include SessionsHelper
  include ApplicationHelper


end