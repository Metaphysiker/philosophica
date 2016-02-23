class BlogpostsController < ApplicationController
  before_action :find_blogpost, only: [:show, :edit, :update, :destroy]
  before_action :find_blog
  before_action :authenticate_user!, only: [:new,:edit, :create, :update, :destroy]

  def show

  end

  def edit

  end

  def update
    if @blogpost.update(blogpost_params)
      redirect_to philblog_path(@blog.url)
    else
      render 'edit'
    end
  end

  def destroy
    @blogpost.destroy
    redirect_to root_path
  end

  def new
    @blogpost = Blogpost.new
  end

  def create
    @blogpost = Blogpost.new(blogpost_params)
    @blogpost.blog_id = @blog.id
    if @blogpost.save
      flash[:success] = "Blogeintrag wurde erstellt!"
      redirect_to philblog_path(@blog.url)
    else
      render 'new'
    end
  end
end

#private

def blogpost_params
  params.require(:blogpost).permit(:content, :title)
end

def find_blogpost
  @blogpost = Blogpost.find(params[:id])
end

def find_blog
  @blog = Blog.find(params[:blog_id])
end