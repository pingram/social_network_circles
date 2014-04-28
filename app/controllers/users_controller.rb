class UsersController < ApplicationController
  def new
    @user = User.new
    @post = Post.new
    3.times { @post.links << Link.new }
  end

  def create
    @user = User.new( user_params )
    @post = @user.posts.build( post_params )
    @post.links.build( link_params )


    if @user.save
      sign_in!(@user)
      redirect_to posts_url
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :posts)
  end

  def post_params
    params.require(:post).permit(:body)
  end

  def link_params
    params.permit( :links => [:title, :url] )
      .require(:links)
      .values
      .reject { |link| link.values.all?(&:empty?) }
  end

end
