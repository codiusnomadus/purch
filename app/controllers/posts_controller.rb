class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  def index
    @posts = Post.all.order('created_at desc')
    @post = @posts.last
  end

  def show
  end

  def new
    @post = Post.new
    @post.uploads.build unless @post.uploads.present?
    authorize @post
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user

    if @post.save
      redirect_to @post, notice: "Post has been created successfully."
    else
      redirect_back fallback_location: @post, alert: "Post could not be created. #{@post.errors.full_messages }}"
    end

    authorize @post
  end

  def edit
  end

  def update
    @post.update(post_params)

    if @post.save
      redirect_to @post, notice: "Post has been updated successfully."
    else
      redirect_back fallback_location: @post, alert: "Post could not be updated. #{@post.errors.full_messages}"
    end
  end

  def destroy
    if @post.destroy
      redirect_to posts_path, notice: "Post has been deleted successfully."
    else
      redirect_back fallback_location: @post, alert: "Post could not be updated."
    end
  end

  private

    def set_post
      @post = Post.find(params[:id])
      authorize @post
    end

    def post_params
      params.require(:post).permit(:title, :category_id, :excerpt, :body,  uploads_attributes: [:id, :upload, :featured] )
    end
end
