class FriendCirclesController < ApplicationController
  def new
    set_users
    @friend_circle = FriendCircle.new
  end

  def create
    set_users
    @friend_circle = FriendCircle.new( friend_circle_params )
    @friend_circle.owner_id = current_user.id

    if @friend_circle.save
      redirect_to posts_url
    else
      flash.now[:errors] = @friend_circle.errors.full_messages
      render :new
    end
  end

  def edit
    set_users
    @friend_circle = FriendCircle.find(params[:id])
  end

  def update
    set_users
    @friend_circle = FriendCircle.find(params[:id])

    if @friend_circle.update_attributes(friend_circle_params)
      redirect_to posts_url
    else
      flash.now[:errors] = @friend_circle.errors.full_messages
      render :new
    end
  end

  def index
  end

  def show
  end

  def destroy
  end

  private

  def set_users
    @users = User.where( 'users.id != ?', current_user.id )
  end

  def friend_circle_params
    params.require(:friend_circle).permit(:name, :member_ids => [])
  end
end
