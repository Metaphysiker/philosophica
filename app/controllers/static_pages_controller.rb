class StaticPagesController < ApplicationController
  def index
    @comingevents = Event.all.limit(5)
  end

  def themen

  end

  def ausbildung

  end

  def forschung

  end
end
