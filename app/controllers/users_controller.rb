class UsersController < ApplicationController
  def index
    @users = User.order(impressions_count: 'DESC') # ソート機能を追加
  end
  
  def show
    @post = current_user.posts
    @user = User.find(params[:id])
    impressionist(@user, nil, unique: [:session_hash])
  end
end
