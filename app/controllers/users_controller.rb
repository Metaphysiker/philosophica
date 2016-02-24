class UsersController < ApplicationController
before_action :only_admin, only: :adminpanel

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

  # GET /resource/edit
   def edit
    @user = User.find(params[:id])
   end

  # PUT /resource
   def update
     @user = User.find(params[:id])
     if @user.update(user_params)
       redirect_to adminpanel_path
     else
       render 'edit'
     end
   end

  def adminpanel
    @users = User.all
  end



end

def user_params
  params.require(:user).permit(:blogrole, :eventrole)
end

def only_admin
  if current_user.nil? || current_user.admin == false
    redirect_to root_path
  end
end