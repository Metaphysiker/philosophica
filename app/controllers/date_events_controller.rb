class DateEventsController < ApplicationController
  before_action :find_event, only: [:show, :create, :new, :edit, :update, :destroy]
  respond_to :html, :js

  def new
    @dateevent = DateEvent.new
    @datelist = "Test"
    @date = params[:date] ? Date.parse(params[:date]) : Date.today
    @first_calendar_day = @date.beginning_of_month.beginning_of_week(:monday)
    @last_calendar_day = @date.end_of_month.end_of_week(:monday)
    @weeks = (@first_calendar_day..@last_calendar_day).to_a.in_groups_of(7)
  end

  def create
    @datelist = params[:date].split(", ")
    @datelist.each do |date|
      params[:date_event][:date] = date
      @dateevent = DateEvent.new(dateevents_params)
      @dateevent.event_id = @event.id
      @dateevent.save
    end
    redirect_to kalender_path
  end
end

private

def dateevents_params
  params.require(:date_event).permit(:date)
end

def find_event
  @event = Event.find(params[:event_id])
end
