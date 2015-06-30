class PostsController < ApplicationController
  before_action :correct_author, only: [:edit, :update]
  before_action :get_subs, only: [:new, :create, :edit, :update]

  def new
    @post = Post.new
    render :new
  end

  def create
    @post = Post.new(post_params)
    @post.author_id = current_user.id
    if @post.save
      redirect_to post_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :new
    end
  end

  def show
    @post = Post.find(params[:id])
    @all_comments = @post.comments_by_parent_id
    render :show
  end

  def edit
    @post = Post.find(params[:id])
    render :edit
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to post_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :edit
    end
  end

  private
    def post_params
      params.require(:post).permit(:title, :url, :content, :sub_ids => [])
    end

    def correct_author
      @post = Post.find(params[:id])
      if current_user.id != @post.author_id
        flash[:errors] = ["Not Your Post"]
        redirect_to subs_url
      end
    end

    def get_subs
      @subs = Sub.all
    end
end
