class UserNotifier < ActionMailer::Base
  default from: 'pranav@whatareyourthoughts.org'

  # SEND WELCOME EMAIL
  def send_signup_email(user)
    @user = user
    mail(to: @user.email,
         subject: "[What are your thoughts?] Welcome, #{@user.first_name}!")
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
