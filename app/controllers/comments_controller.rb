# rubocop:disable Metrics/LineLength
class CommentsController < ApplicationController
  def create
    # raise params
    @comment = Comment.new(comment_params)

    respond_to do |format|
      if @comment.save
        @conversation = Conversation.find(params[:comment][:conversation_id])
        @conversation.participations.each do |part|
          part.update_attribute(:read, false) unless part.user == current_user
        end
        format.html { redirect_to participation_path(params[:comment][:participation_id]), notice: 'Message sent.' }
      else
        format.html { redirect_to participation_path(params[:comment][:participation_id]), notice: 'Failed to send message.' }
      end
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :participation_id, :conversation_id)
  end
end
