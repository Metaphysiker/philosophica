class TagsController < ApplicationController
  before_action :authenticate_user!, only: [:new,:edit, :create, :update, :destroy]

  def index
    @tags = ActsAsTaggableOn::Tag.all
  end

  def show
    @tag =  ActsAsTaggableOn::Tag.find(params[:id])
    @infos = Info.tagged_with(@tag.name)

    @date = Date.today()
    @dateplusyear = @date + 2.years
    @comingdays = (@date..@dateplusyear)
    @comingevents = Event.where(published: true).tagged_with(@tag.name)
  end
end
