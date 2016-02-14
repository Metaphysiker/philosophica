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

    mg_client = Mailgun::Client.new ENV['api_key']
    message_params = {:from    => ENV['gmail_username'],
                      :to      => @user.email,
                      :subject => 'Sample Mail using Mailgun API',
                      :text    => 'This mail is sent using Mailgun API via mailgun-ruby'}
    mg_client.send_message ENV['domain'], message_params

  end
end

