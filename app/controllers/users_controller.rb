class UsersController < ApplicationController
before_action :only_admin, only: :adminpanel
respond_to :html, :js

  def show
    @user = User.find_by_username(params[:username])
    @tags = @user.tag_list

    @infosall = Array.new
    @tags.each do |tag|
      @infosall = @infosall + Info.tagged_with(tag)
    end

    @infosall.uniq!
    @infosall.sort! { |a,b| b.created_at <=> a.created_at }

    @eventsall = Array.new
    @tags.each do |tag|
      @eventsall = @eventsall + Event.where(published: true).tagged_with(tag)
    end

    @eventsall.uniq!
    @eventsall.sort! { |a,b| a.date <=> b.date }

    @date = Date.today()
    @dateplusyear = @date + 2.years
    @comingdays = (@date..@dateplusyear)
    @comingevents = @eventsall


    @events = @eventsall
    @date = params[:date] ? Date.parse(params[:date]) : Date.today
    @first_calendar_day = @date.beginning_of_month.beginning_of_week(:monday)
    @last_calendar_day = @date.end_of_month.end_of_week(:monday)
    @weeks = (@first_calendar_day..@last_calendar_day).to_a.in_groups_of(7)
    # @eventics = Event.where('extract(month from date) = ?', @date.month).order(:date)
    # @eventics= Event.joins(:date_events).where('extract(month from date) = ?', @date.month).order(:date)
    @eventics = Event.joins(:date_events).where('extract(month from date_events.date) = ?', @date.month).where(published: true)
    @alldays = (@first_calendar_day..@last_calendar_day)
  end

  # GET /resource/edit
   def edit
    @user = User.find(params[:id])
   end

  # PUT /resource
   def update
     @user = User.find(params[:id])
     if @user.update(user_params)
       redirect_to adminpanel_path
     else
       render 'edit'
     end
   end

  def adminpanel
    @users = User.all
  end

  def checkname
    name = params[:name]
    return User.exists?(:username => name)
  end

def fileContent

  name = params[:file_name]

  boolean = User.exists?(:username => name)

  logger.debug boolean

  if request.xhr?
    render :json => {
        :file_content => boolean
    }
  end
end



end

def user_params
  params.require(:user).permit(:blogrole, :eventrole)
end

def only_admin
  if current_user.nil? || current_user.admin == false
    redirect_to root_path
  end
end