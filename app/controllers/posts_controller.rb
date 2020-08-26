class PostsController < ApplicationController
  before_action :move_to_index, except: [:index, :show]

  def index
    @post = Post.page(params[:page]).per(6).order("created_at DESC")
    @posts = Post.order(impressions_count: 'DESC')
    @postss = Post.all.sort {|a,b| b.liked_users.count <=> a.liked_users.count}
  end

  def new
    @post = Post.new
  end

def create
  @post=Post.create(post_params)
  if @post.save
    redirect_to "/"
  else
    render :new
  end
end

def edit
  @post = Post.find(params[:id])
end

def update
  @post = Post.find(params[:id])
  if @post.update(post_params)
    redirect_to post_path
  else
    render :edit
  end
end

def show
  @post = Post.find(params[:id])
  @user = Post.find(params[:id])
  @posts = Post.order(impressions_count: 'DESC')
  @postss = Post.all.sort {|a,b| b.liked_users.count <=> a.liked_users.count}
  impressionist(@post, nil, unique: [:session_hash])
  @comment = Comment.new
  @comments = @post.comments.includes(:user)
  @like = Like.new
end

def destroy
  @post = Post.find(params[:id])
  if @post.destroy
    redirect_to "/"
  else
    render :show
  end
end

private
  def post_params
    params.require(:post).permit(:vocab, :definition, :example, :image).merge(user_id: current_user.id)
  end

  def move_to_index
    unless user_signed_in?
      redirect_to action: :index
    end
  end

end