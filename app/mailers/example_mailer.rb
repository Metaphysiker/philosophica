class ExampleMailer < ApplicationMailer
  default from: "sandro.raess@philosophie.ch"

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

    mg_client = Mailgun::Client.new ENV['key-00189745ce652e42d6f1ee591b9f4f6a']
    message_params = {:from    => ENV['philotester5@gmail.com'],
                      :to      => @user.email,
                      :subject => 'Sample Mail using Mailgun API',
                      :text    => 'This mail is sent using Mailgun API via mailgun-ruby'}
    mg_client.send_message ENV['philosophica.ch'], message_params

  end
end

