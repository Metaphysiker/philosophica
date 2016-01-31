class StaticPagesController < ApplicationController
  def index
   # @comingevents = Event.all.limit(5)
    @comingevents = Event.where('date > ?', DateTime.now).limit(5).order(:date)
  end

  def themen

  end

  def ausbildung

  end

  def forschung

  end
end
