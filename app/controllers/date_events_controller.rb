class DateEventsController < ApplicationController
  before_action :find_event, only: [:show, :new, :edit, :update, :destroy]

  def new
    @dateevent = DateEvent.new

    @date = params[:date] ? Date.parse(params[:date]) : Date.today
    @first_calendar_day = @date.beginning_of_month.beginning_of_week(:monday)
    @last_calendar_day = @date.end_of_month.end_of_week(:monday)
    @weeks = (@first_calendar_day..@last_calendar_day).to_a.in_groups_of(7)
  end

  def create
    @dateevent = DateEvent.new(dateevents_params)
  end
end

private

def dateevents_params
  params.require(:date_event).permit(:date)
end

def find_event
  @event = Event.find(params[:event_id])
end
