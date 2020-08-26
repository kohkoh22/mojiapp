class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show, :edit, :update]
  def index
    # @users = User.order(impressions_count: 'DESC') # ソート機能を追加
    @users = User.all
  end
  
  def show
    @post = current_user.posts
    @user = User.find(params[:id])
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

  private
  def user_params
    params.fetch(:user, {}).permit(:nickname)
  end
end
