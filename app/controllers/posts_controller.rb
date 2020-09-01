class PostsController < ApplicationController
  before_action :move_to_index, except: [:index, :show, :search]
  before_action :set_tag, only: [:new, :edit, :update, :show, :search]
  before_action :set_post, only: [:edit, :update, :show, :destroy]
  before_action :set_rank, only: [:search, :index, :show]

  def index
    @tags = ActsAsTaggableOn::Tag.all.sort {|a,b| b.taggings_count <=> a.taggings_count}
    if params[:tag]
      @post = Post.tagged_with(params[:tag])
    else
      @post = Post.page(params[:page]).per(9).order("created_at DESC")
    end
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
  end

  def update
    if @post.update(post_params)
      redirect_to post_path
    else
      render :edit
    end
  end

  def show
    @comment = Comment.new
    @comments = @post.comments.includes(:user)
    @like = Like.new
    impressionist(@post, nil, unique: [:session_hash])
  end

  def destroy
    if @post.destroy
      redirect_to "/"
    else
      render :show
    end
  end

  def search
    @post = Post.search(params[:keyword])
  end

  private
    def post_params
      params.require(:post).permit(:vocab, :definition, :example, :image, :tag_list).merge(user_id: current_user.id)
    end

    def set_tag
      @tags = ActsAsTaggableOn::Tag.all
    end

    def set_post
      @post = Post.find(params[:id])
    end

    def set_rank
      @posts = Post.order(impressions_count: 'DESC')
      @postss = Post.all.sort {|a,b| b.liked_users.count <=> a.liked_users.count}
    end

    def move_to_index
      unless user_signed_in?
        redirect_to action: :index
    end
    end
end