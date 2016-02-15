class TagsController < ApplicationController
  before_action :authenticate_user!, only: [:new,:edit, :create, :update, :destroy]

  def index
    @tags = ActsAsTaggableOn::Tag.all
  end

  def show
    @tag =  ActsAsTaggableOn::Tag.find(params[:id])
    @events = Event.tagged_with(@tag.name)
    @infos = Info.tagged_with(@tag.name)
  end
end
