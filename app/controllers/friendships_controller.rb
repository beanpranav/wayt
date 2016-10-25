# rubocop:disable Metrics/LineLength
class FriendshipsController < ApplicationController
  before_action :set_friendship, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_involvement, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  def index
    @friendships = Friendship.all
  end

  def show
  end

  def new
    @friendship = Friendship.new
  end

  def edit
  end

  def create
    @friendship = Friendship.new(friendship_params)

    respond_to do |format|
      if @friendship.save
        format.html { redirect_to @friendship, notice: 'Added friend.' }
      else
        format.html { render action: 'new' }
      end
    end
  end

  def update
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
      format.html { redirect_to friendships_url }
    end
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
