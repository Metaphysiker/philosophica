class EventsController < ApplicationController
  def index
    @events = Event.all
    @date = params[:date] ? Date.parse(params[:date]) : Date.today
  end
end
