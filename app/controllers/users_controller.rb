class UsersController < ApplicationController
  before_action :authenticate_user!, only: [ :edit, :update]
  before_action :set_user, only: [:show, :edit, :update, :following, :followers]
  def index
    @users = User.all.sort {|a,b| b.followed.count <=> a.followed.count}
  end
  
  def show
    @tags = ActsAsTaggableOn::Tag.all
  end

  def edit
    unless @user == current_user
       redirect_to user_path(@user)
    end
  end
  
  def update
    if @user.update(user_params)
      redirect_to user_path(current_user)
    else
     redirect_to edit_user_path(current_user)
    end
  end

  def search
    @users = User.search(params[:keyword])
  end

  def following
    @users = @user.follower
    render 'following'
  end

  def followers
    @users = @user.followed
    render 'followed'
  end


  private
  def user_params
    params.fetch(:user, {}).permit(:nickname, :image, :profile)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
