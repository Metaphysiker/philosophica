class StaticPagesController < ApplicationController
  before_action :authenticate_user!, only: [:new,:edit, :create, :update, :destroy]
  respond_to :html, :js

  def index
   # @comingevents = Event.all.limit(5)
    @comingevents = Event.where('date > ?', DateTime.now).limit(5).order(:date)
    @forschungs = Info.where(kind: '1').limit(4).order(:created_at).reverse_order
    @neugierigs = Info.where(kind: '2').limit(4).order(:created_at).reverse_order
  end

  def themen

  end

  def ausbildung
    gon.products = Event.all.limit(5)
  end

  def forschung

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
    @eventics = Event.where('extract(month from date) = ?', @date.month).order(:date)
  end
end
