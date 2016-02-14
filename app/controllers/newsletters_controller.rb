class NewslettersController < ApplicationController
  def index
    @newsletters = Newsletter.all
  end

  def new
    @newsletter = Newsletter.new
  end

  def create
    @newsletter = Newsletter.new(newsletter_params)
    if @newsletter.save
      # @user = User.find(current_user.id)
      #ExampleMailer.sample_email(@user).deliver
      redirect_to newsletters_path
    else
      render 'new'
    end
  end

  private

  def newsletter_params
    params.require(:newsletter).permit(:name)
  end


end

