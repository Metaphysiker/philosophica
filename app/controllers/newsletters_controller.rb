class NewslettersController < ApplicationController
  before_action :authenticate_user!, only: [:new,:edit, :create, :update, :destroy]

  def index
    @newsletters = Newsletter.all
  end

  def new
    @newsletter = Newsletter.new
  end

  def create
    @newsletter = Newsletter.new(newsletter_params)
    if @newsletter.save
      @user = User.all
      @user.each do |user|
        ExampleMailer.sample_email(user).deliver
      end
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

