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
    @participation = @conversation.my_participation(current_user.id)
    @comment = @participation.comments.build
    @comments = @conversation.comments
  end

  def new
    @conversation = current_user.conversations.build
  end

  def edit
  end

  def create
    @conversation = current_user.conversations.build(conversation_params)
    @conversation.recipient_ids = params[:recipient].nil? ? [] : params[:recipient][:ids]
    # raise params

    respond_to do |format|
      if params[:comment][:content].present? && @conversation.save
        owner = @conversation.participations.build(user_id: current_user.id, read: true, others_count: 0)
        owner.save
        comment = @conversation.comments.build(participation_id: owner.id, content: params[:comment][:content])
        comment.save
        format.html { redirect_to @conversation, notice: 'Conversation started' }
      else
        format.html { render action: 'new' }
        unless params[:comment][:content].present?
          @conversation.errors.add(:subject, "& first comment can't be blank")
        end
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
    unless @conversation.owner == current_user
      redirect_to root_path, notice: "You don't have persmission to view this page."
    end
  end

  def authenticate_participation
    unless @conversation.participants.any? { |p| p == current_user }
      redirect_to root_path, notice: "You don't have persmission to view this page."
    end
  end

  def conversation_params
    params.require(:conversation).permit(:subject, :recipient_ids, :source_link, :slug, :user_id)
  end
end
