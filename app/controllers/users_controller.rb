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
      @eventsall = @eventsall + Event.where(date: Date.current..(Date.current + 7.days)).tagged_with(tag)
    end

    @eventsall.uniq!
    @eventsall.sort! { |a,b| a.date <=> b.date }
  end



end