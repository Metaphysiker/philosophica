class TagsController < ApplicationController
  def index
    @tags = ActsAsTaggableOn::Tag.all
  end

  def show
    @tag =  ActsAsTaggableOn::Tag.find(params[:id])
    @events = Event.tagged_with(@tag.name)
    @infos = Info.tagged_with(@tag.name)
    @everything = (@events + @infos)
    @everything.sort! { |a,b| b.created_at <=> a.created_at }
    @everything.reverse!
  end
end
