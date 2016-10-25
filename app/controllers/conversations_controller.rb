# rubocop:disable Metrics/LineLength
class ConversationsController < ApplicationController
  before_action :set_conversation, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_owner, only: [:edit, :update, :destroy]
  before_action :authenticate_participation, only: [:show]
  before_action :authenticate_user!

  def index
    @conversations = Conversation.all
  end

  def show
  end

  def new
    @conversation = current_user.conversations.build
  end

  def edit
  end

  def create
    @conversation = current_user.conversations.build(conversation_params)

    respond_to do |format|
      if @conversation.save
        owner = @conversation.participations.build(user_id: current_user.id, others_count: 0)
        owner.save
        format.html { redirect_to @conversation, notice: 'Conversation was successfully created.' }
      else
        format.html { render action: 'new' }
      end
    end
  end

  def update
    respond_to do |format|
      if @conversation.update(conversation_params)
        format.html { redirect_to @conversation, notice: 'Conversation was successfully updated.' }
      else
        format.html { render action: 'edit' }
      end
    end
  end

  def destroy
    @conversation.destroy
    respond_to do |format|
      format.html { redirect_to conversations_url }
    end
  end

  private

  def set_conversation
    @conversation = Conversation.friendly.find(params[:id])
  end

  def authenticate_owner
    unless @conversation.user == current_user
      redirect_to root_path, notice: "You don't have persmission to view this page."
    end
  end

  def authenticate_participation
    unless @conversation.participants.any? { |p| p == current_user }
      redirect_to root_path, notice: "You don't have persmission to view this page."
    end
  end

  def conversation_params
    params.require(:conversation).permit(:subject, :source_author, :source_link, :source_content, :first_comment, :slug, :user_id, :friendship_id)
  end
end
