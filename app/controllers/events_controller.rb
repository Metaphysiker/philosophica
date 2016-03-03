class EventsController < ApplicationController
  before_action :find_event, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new,:edit, :create, :update, :destroy]


  def index
    @events = Event. all.order("date")
  end

  def show
    @user = User.find(@event.user_id)
  end

  def new
    @event = Event.new

    @date = params[:date] ? Date.parse(params[:date]) : Date.today
    @first_calendar_day = @date.beginning_of_month.beginning_of_week(:monday)
    @last_calendar_day = @date.end_of_month.end_of_week(:monday)
    @weeks = (@first_calendar_day..@last_calendar_day).to_a.in_groups_of(7)
  end

  def edit

  end

  def create
    params[:event][:tag_list] = params[:event][:tag_list].join(',')
    @event = Event.new(event_params)
    @event.user_id = current_user.id

    if instantpublish?
      @event.published = true
    else
      @event.published = false
      ExampleMailer.event_unpublished(current_user).deliver
      @admins = User.where(admin: true)
      @admins.each do |admin|
        ExampleMailer.new_event_mail(admin).deliver
      end
    end
    if @event.save
      flash[:success] = "Der Event wurde erstellt!"
      redirect_to new_event_date_event_path(@event)
    else
      render 'new'
    end
  end

  def update
    if @event.update(event_params)
      redirect_to event_path(@event)
    else
      render 'edit'
    end
  end

  def destroy
    @event.destroy
    redirect_to calendar_show_path
  end

  def publishpanel
    if allowed?
    @unpublished = Event.where(published: false)
    else
      redirect_to root_path
    end
    end

end


def allowed?
  if current_user.admin == true || current_user.blogrole == "editor"
    return true
  else
    return false
  end
end

private

def event_params
  params.require(:event).permit(:name, :content, :date, :tag_list, :published)
end

def find_event
  if params[:event_id].nil?
    @event = Event.find(params[:id])
  else
    @event = Event.find(params[:event_id])
  end
end

def find_eventcreate
  @event = Event.find(params[:event_id])
end

def instantpublish?
  if current_user.admin? == true || current_user.eventrole == "editor"
    return true
  else
    return false
  end
end

