# rubocop:disable Metrics/LineLength
class FriendshipsController < ApplicationController
  before_action :set_friendship, only: [:show, :edit, :update, :destroy, :accept]
  before_action :authenticate_involvement, only: [:show, :edit, :update, :destroy]
  # before_action :authenticate_admin, only: [:index]
  before_action :authenticate_user!

  def index
    @friendships = current_user.all_friendships
    @pending_count = @friendships.select { |f| f.status == 'pending' }.count
  end

  def show
  end

  def new
    @friendship = current_user.friendships.build
  end

  def edit
  end

  def create
    if params[:friend_email] == ''
      # empty
      respond_to do |format|
        format.html { redirect_to new_friendship_path, notice: 'Friend\'s email is required.' }
      end
    else

      friend = User.find_by(email: params[:friend_email])
      if friend.nil?
        # non-user
        respond_to do |format|
          format.html { redirect_to new_friendship_path, notice: "Friend not found!<br>The email <b>#{params[:friend_email]}</b> you tried might be incorrect <br>Or friend may not be an existing WAYT member.".html_safe }
        end

      elsif friend == current_user
        # current user
        respond_to do |format|
          format.html { redirect_to new_friendship_path, notice: 'I see what you did there! :)'.html_safe }
        end

      elsif current_user.friendships.any? { |p| p.friend_id == friend.id } || current_user.inverse_friendships.any? { |p| p.user_id == friend.id }
        # existing friend
        respond_to do |format|
          format.html { redirect_to new_friendship_path, notice: "<b>#{friend.name}</b> is already a friend!".html_safe }
        end

      elsif friend.friendships.count + friend.inverse_friendships.count == 5 # TODO: update
        # friend has full network
        respond_to do |format|
          format.html { redirect_to new_friendship_path, notice: "<b>#{friend.name}</b> already has maximum number of allowable friends!<br>Please ask them to make space before trying again".html_safe }
        end

      else
        # create new friendship
        @friendship = current_user.friendships.build(friend_id: friend.id)

        respond_to do |format|
          if @friendship.save
            UserNotifier.friend_request_send_email(@friendship.user, @friendship.friend).deliver if @friendship.friend.friendship_notifications?
            format.html { redirect_to friendships_path, notice: 'Friend request sent.' }
          else
            format.html { render action: 'new' }
          end
        end
      end

    end
  end

  def update
    # raise params
    respond_to do |format|
      if @friendship.update(friendship_params)
        format.html { redirect_to @friendship, notice: 'Updated friendship.' }
      else
        format.html { render action: 'edit' }
      end
    end
  end

  def destroy
    @friendship.destroy
    respond_to do |format|
      format.html { redirect_to friendships_url, notice: 'Friend lost.' }
    end
  end

  def accept
    @friendship.update_attribute(:status, 'active')
    UserNotifier.friend_request_accept_email(@friendship.user, @friendship.friend).deliver if @friendship.user.friendship_notifications?
    redirect_to friendships_path, notice: 'Friend request accepted. You can now have discussions with them.'
  end

  private

  def set_friendship
    @friendship = Friendship.find(params[:id])
  end

  def authenticate_involvement
    unless @friendship.user == current_user || @friendship.friend == current_user
      redirect_to root_path, notice: "You don't have persmission to view this page."
    end
  end

  def friendship_params
    params.require(:friendship).permit(:user_id, :friend_id, :status)
  end
end
