class PostsController < ApplicationController
  def new
    set_friend_circles
    @post = Post.new
  end

  def create
    set_friend_circles
    @post = Post.new(post_params)
    @post.user_id = current_user.id

    if @post.save
      redirect_to posts_url
    else
      flash.now[:errors] = @post.errors.full_messages
      render :new
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def index
  end

  def show
  end

  private

  def set_friend_circles
    @friend_circles = current_user.owned_circles
  end

  def post_params
    params.require(:post).permit(:body, :friend_circle_ids => [])
  end
end
