class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show, :edit, :update]
  def index
    @users = User.all.sort {|a,b| b.followed.count <=> a.followed.count}
  end
  
  def show
    @post = current_user.posts
    @user = User.find(params[:id])
    @tags = ActsAsTaggableOn::Tag.all
    # impressionist(@user, nil, unique: [:session_hash])
  end

  def edit
    @user = User.find(params[:id])
    unless @user == current_user
       redirect_to user_path(@user)
     end
  end
  
  def update
    @user = User.find(params[:id])
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
    @user  = User.find(params[:id])
    @users = @user.follower
    render 'following'
end

def followers
  @user  = User.find(params[:id])
  @users = @user.followed
  render 'followed'
end


  private
  def user_params
    params.fetch(:user, {}).permit(:nickname, :image, :profile)
  end
end
