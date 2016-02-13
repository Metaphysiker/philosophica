class InfosController < ApplicationController
before_action :find_info, only: [:show, :edit, :update, :destroy]

  def show

  end

  def edit

  end

  def update
    if @info.update(info_params)
      redirect_to info_path(@info)
    else
      render 'edit'
    end
  end

  def destroy
    @info.destroy
    redirect_to root_path
  end

  def index
    @infos = Info.all
  end

  def new
    @info = Info.new
  end

  def create
    params[:info][:tag_list] = params[:info][:tag_list].join(',')
    @info = Info.new(info_params)
    @info.user_id = current_user.id
    if @info.save
      flash[:success] = "Info wurde erstellt!"
      redirect_to info_path(@info)
    else
      render 'new'
    end
  end
end

def getcategory(number)
  if number == 1
    return "Forschung"
  elsif
    number == 2
    return "Neugier"
  else
    return "Nope"
  end
end

private

def info_params
  params.require(:info).permit(:name, :content, :kind, :tag_list)
end

def find_info
  @info = Info.find(params[:id])
end