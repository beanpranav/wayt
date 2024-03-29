# rubocop:disable Metrics/LineLength
class UserNotifier < ActionMailer::Base
  default from: '"What are your thoughts?" <notification@whatareyourthoughts.org>'

  # ADMIN EMAILS: NEW USER
  def admin_new_user_email(user)
    @user = user
    mail(to: 'pranav@whatareyourthoughts.org',
         subject: "[New User] #{@user.name} just signed up!")
  end

  # WELCOME EMAIL
  def welcome_email(user)
    @user = user
    mail(to: @user.email,
         subject: "Welcome, #{@user.first_name}!")
  end

  # FRIEND REQUESTS: SEND & ACCEPT
  def friend_request_send_email(user, friend)
    @user = user
    @friend = friend
    mail(to: @friend.email,
         subject: "#{@user.first_name} has sent you a friend request!")
  end

  def friend_request_accept_email(user, friend)
    @user = user
    @friend = friend
    mail(to: @user.email,
         subject: "#{@friend.first_name} has accepted your friend request!")
  end

  # NEW CONVERSATION
  def new_conversation_email(conversation, sender, recipient_id)
    @user = sender
    @friend = User.find(recipient_id)
    @conversation = conversation
    mail(to: @friend.email,
         subject: "#{@conversation.subject} - #{@user.first_name} started discussing.")
  end

  # NEW PARTICIPANT
  def new_participant_email(conversation, sender, recipient_id)
    @user = sender
    @friend = User.find(recipient_id)
    @conversation = conversation
    mail(to: @friend.email,
         subject: "#{@conversation.subject} - #{@user.first_name} added you.")
  end

  # NEW COMMENT
  def new_comment_email(conversation, sender, recipient)
    @user = sender
    @friend = recipient
    @conversation = conversation
    mail(to: @friend.email,
         subject: "#{@user.first_name} replied to #{@conversation.subject}")
  end
end
