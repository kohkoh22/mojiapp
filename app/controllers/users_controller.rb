class UsersController < ApplicationController
  def show
    @post = current_user.posts
  end
end
