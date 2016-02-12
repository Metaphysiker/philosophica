class EventsController < ApplicationController
  before_action :find_event, only: [:show, :edit, :update, :destroy]

  def index
    @events = Event. all.order("date")
  end

  def show
    @user = User.find(@event.user_id)
  end

  def new
    @event = Event.new
  end

  def edit

  end

  def create
    @event = Event.new(event_params)
    @event.user_id = current_user.id
    if @event.save
      flash[:success] = "Der Event wurde erstellt!"
      redirect_to event_path(@event)
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

  private

  def event_params
    params.require(:event).permit(:name, :content, :date)
  end

  def find_event
    @event = Event.find(params[:id])
  end


end
