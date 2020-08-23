class PostsController < ApplicationController
  def index
    @post = Post.all
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

def show
  @post = Post.find(params[:id])
  # @comment = Comment.new
  # @comments = @post.comments.includes(:user)
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
    params.require(:post).permit(:vocab, :definition, :example, :image)
  end
end