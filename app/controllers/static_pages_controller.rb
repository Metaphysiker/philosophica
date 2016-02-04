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

  end
end
