# rubocop:disable Metrics/LineLength
class UserNotifier < ActionMailer::Base
  default from: '"What are your thoughts?" <notification@whatareyourthoughts.org>'

  # WELCOME EMAIL
  def welcome_email(user)
    @user = user
    mail(to: @user.email,
         subject: "[What are your thoughts?] Welcome, #{@user.first_name}!")
  end

  # FRIEND REQUESTS: SEND & ACCEPT
  def friend_request_send_email(user, friend)
    @user = user
    @friend = friend
    mail(to: @friend.email,
         subject: "[What are your thoughts?] #{@user.first_name} has sent you a friend request!")
  end

  def friend_request_accept_email(user, friend)
    @user = user
    @friend = friend
    mail(to: @user.email,
         subject: "[What are your thoughts?] #{@friend.first_name} has accepted your friend request!")
  end

  # NEW CONVERSATION
  def new_conversation_email(conversation, sender, recipient_id)
    @user = sender
    @friend = User.find(recipient_id)
    @conversation = conversation
    mail(to: @friend.email,
         subject: "[#{@user.first_name} started a discussion] #{@conversation.subject}")
  end

  # NEW PARTICIPANT
  def new_participant_email(conversation, sender, recipient_id)
    @user = sender
    @friend = User.find(recipient_id)
    @conversation = conversation
    mail(to: @friend.email,
         subject: "[#{@user.first_name} invited you to a discussion] #{@conversation.subject}")
  end

  # NEW COMMENT
  def new_comment_email(conversation, sender, recipient)
    @user = sender
    @friend = recipient
    @conversation = conversation
    mail(to: @friend.email,
         subject: "[#{@user.first_name} wrote a reply] #{@conversation.subject}")
  end

  # ADMIN EMAILS: NEW USER
  def admin_new_user_email(user)
    @user = user
    mail(to: admin_email,
         subject: "[WAYT? New User] #{@user.name} just signed up!")
  end
end
