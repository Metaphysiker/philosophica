class NewEventMail < ApplicationMailer
  default from: "philotester5@gmail.com"

  def new_event_mail(user)
    @user = user

    mail(to: @user.email, subject: 'Event veröffentlichen')

  end
end

