class UsersController < ApplicationController

  def show
    @user = User.find_by_username(params[:username])
    @tags = @user.tag_list

    @infosall = Array.new
    @tags.each do |tag|
      @infosall = @infosall + Info.tagged_with(tag)
    end

    @infosall.uniq!
    @infosall.sort! { |a,b| b.created_at <=> a.created_at }

    @eventsall = Array.new
    @tags.each do |tag|
      @eventsall = @eventsall + Event.tagged_with(tag)
    end

    @eventsall.uniq!
    @eventsall.sort! { |a,b| b.date <=> a.date }

  end



end