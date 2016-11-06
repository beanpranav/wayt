# rubocop:disable Metrics/LineLength
class UserNotifier < ActionMailer::Base
  default from: 'pranav@whatareyourthoughts.org'

  # WELCOME EMAIL
  def send_signup_email(user)
    @user = user
    mail(to: @user.email,
         subject: "[What are your thoughts?] Welcome, #{@user.first_name}!")
  end


  # FRIEND REQUESTS: SEND & ACCEPT
  def send_friend_request_email(user, friend)
    @user = user
    @friend = friend
    mail(to: @friend.email,
         subject: "[What are your thoughts?] #{@user.first_name} has sent you a friend request!")
  end

  def accept_friend_request_email(user, friend)
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
         subject: "[What are your thoughts?] #{@user.first_name} started a discussion - #{@conversation.subject}")
  end

  # # SEND NEW USER INVITE
  # def new_user_invite(invite, signup_url)
  #   @invite = invite
  #   @signup_url = signup_url
  #   mail(to: @invite.recipient_email,
  #        subject: "[What are your thoughts?] #{@invite.sender.first_name} personally has invited you!")
  # end

  # def new_user_invite_copy(invite)
  #   @invite = invite
  #   mail(to: @invite.sender.email,
  #        subject: "[What are your thoughts?] #{@invite.sender.first_name} personally has invited you!")
  # end
end
