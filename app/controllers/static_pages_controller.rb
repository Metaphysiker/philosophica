class StaticPagesController < ApplicationController
  def index
   # @comingevents = Event.all.limit(5)
    @comingevents = Event.where('date > ?', DateTime.now).limit(5).order(:date)
    @forschungs = Info.where(kind: '1').limit(4).order(:created_at).reverse_order
    @neugierigs = Info.where(kind: '2').limit(4).order(:created_at).reverse_order
  end

  def themen
    @date = params[:date] ? Date.parse(params[:date]) : Date.today
    @events = Event.all
  end

  def ausbildung
    gon.products = Event.all.limit(5)
  end

  def forschung
    @events = Event.all
    @date = params[:date] ? Date.parse(params[:date]) : Date.today
    @first_calendar_day = @date.beginning_of_month.beginning_of_week(:monday)
    @last_calendar_day = @date.end_of_month.end_of_week(:monday)

    @weeks = (@first_calendar_day..@last_calendar_day).to_a.in_groups_of(7)
  end

  def kalender
    @events = Event.all
    @date = params[:date] ? Date.parse(params[:date]) : Date.today
    @first_calendar_day = @date.beginning_of_month.beginning_of_week(:monday)
    @last_calendar_day = @date.end_of_month.end_of_week(:monday)

    @weeks = (@first_calendar_day..@last_calendar_day).to_a.in_groups_of(7)
  end
end
