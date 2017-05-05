class Api::BaseController < ApplicationController
  # To identify HTML forms that are created by your Rails app
  # Rails add a hidden field that contains a CSRF (Cross-site request forgery) token.
  # For a JSON API, we want to skip this security check and use our own.
  # This is necessary otherwise Rails will disallow all POST requests made without
  # a CSRF token signed with Rails Secret from 'config/secret.yml'
  skip_before_filter :verify_authenticity_token

  before_action :authenticate_user

  private

  def authenticate_user
    @user = User.find_by_api_token params[:api_token]
    # head will send an empty HTTP response with a code that is inferred by the
    # symbol you pass as an argument to the 'head' method.
    # http://billpatrianakos.me/blog/2013/10/13/list-of-rails-status-code-symbols/
    head :unauthorized if @user.nil?
  end
end
