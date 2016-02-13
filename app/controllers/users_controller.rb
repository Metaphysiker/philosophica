class UsersController < ApplicationController

  def show
    @user = User.find_by_username(params[:username])
    @tags = @user.tag_list

    @infosall = Info.tagged_with(@tags).uniq!
  end

end