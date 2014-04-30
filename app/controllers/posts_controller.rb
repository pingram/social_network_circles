class PostsController < ApplicationController
  before_action :ensure_signed_in

  def new
    set_friend_circles
    @post = Post.new
    3.times { @post.links << Link.new }
  end

  def create
    set_friend_circles
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    @post.links.new( link_params )

    if @post.save
      redirect_to posts_url
    else
      (3 - @post.links.length).times { @post.links << Link.new }
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
    @posts = current_user.shared_posts
    unless current_user.posts.nil?
      @posts = @posts + current_user.posts
    end
  end

  def show
  end

  private

  def set_friend_circles
    @friend_circles = current_user.owned_circles
  end

  def link_params
    params.permit( :links => [:title, :url] )
      .require(:links)
      .values
      .reject { |link| link.values.all?(&:empty?) }
  end

  def post_params
    params.require(:post).permit(:body, :friend_circle_ids => [])
  end
end
