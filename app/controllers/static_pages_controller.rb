class StaticPagesController < ApplicationController
  def index
   # @comingevents = Event.all.limit(5)
    @comingevents = Event.where('date > ?', DateTime.now).limit(5).order(:date)
  end

  def themen
    @date = params[:date] ? Date.parse(params[:date]) : Date.today
    @events = Event.all
  end

  def ausbildung

  end

  def forschung
    @date = params[:date] ? Date.parse(params[:date]) : Date.today
    @first_calendar_day = @date.beginning_of_month.beginning_of_week(:sunday)
    @last_calendar_day = @date.end_of_month.end_of_week(:sunday)

    @weeks = (@first_calendar_day..@last_calendar_day).to_a.in_groups_of(7)
  end
end
