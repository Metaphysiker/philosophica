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

    mail(to: @user.email, subject: 'Sample Email')

  end
end

