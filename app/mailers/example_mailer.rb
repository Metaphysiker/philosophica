class ExampleMailer < ApplicationMailer
  default from: "philotester5@gmail.com"

  def sample_email(user)
    @user = user
    @tags = @user.tag_list
    @infosall = Array.new
    @tags.each do |tag|
      @infosall = @infosall + Info.tagged_with(tag)
    end

    @infosall.uniq!
    @infosall.sort! { |a,b| b.created_at <=> a.created_at }

    @eventsall = Array.new
    @tags.each do |tag|
      @eventsall = @eventsall + Event.where(date: Date.current..(Date.current + 7.days)).tagged_with(tag)
    end

    @eventsall.uniq!
    @eventsall.sort! { |a,b| a.date <=> b.date }

    mail(to: @user.email, subject: 'Sample Email')

  end

  def new_event_mail(user)
    @user = user

    mail(to: @user.email, subject: 'Event veröffentlichen')

  end

  def event_unpublished(user)
    @user = user

    mail(to: @user.email, subject: 'Eventeintrag wird überprüft')

  end
end

