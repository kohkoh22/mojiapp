class RegistrationsController < ApplicationController
  # before_action :forbid_test_user, {only: [:edit,:update,:destroy]}
  def create
    if params[:sns_auth] == 'true'
      pass = Devise.friendly_token
      params[:user][:password] = pass
      params[:user][:password_confirmation] = pass
    end
    super
  end
end
