# rubocop:disable Metrics/LineLength
class ConversationsController < ApplicationController
  before_action :set_conversation, only: [:show, :edit, :update, :destroy]
  before_action :owner?, only: [:edit, :update, :destroy]
  before_action :invovled?, only: [:show]

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
    @conversation = Conversation.new(conversation_params)

    respond_to do |format|
      if @conversation.save
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

  def owner?
    if @conversation.user == current_user
      true
    else
      false
    end
  end

  def invovled?
    if @conversation.participants.any? { |p| p == current_user }
      true
    else
      false
    end
  end

  def conversation_params
    params.require(:conversation).permit(:subject, :source_author, :source_link, :source_content, :slug, :user_id, :friendship_id)
  end
end
