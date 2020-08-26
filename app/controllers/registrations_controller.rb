class RegistrationsController < ApplicationController
  # before_action :forbid_test_user, {only: [:edit,:update,:destroy]}


  # private
  # def forbid_test_user
  #     if @user.email == "test@test.com"
  #       flash[:notice] = "テストユーザーのため変更できません"
  #       redirect_to root_path
  #     end
  # end
end
