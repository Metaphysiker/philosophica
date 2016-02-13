class BlogsController < ApplicationController
  before_action :find_blog, only: [:edit, :update, :destroy]

  def show
    @blog = Blog.find_by_name(params[:name])
  end

  def edit

  end

  def update
    if @blog.update(blog_params)
      redirect_to blog_path(@blog)
    else
      render 'edit'
    end
  end

  def destroy
    @info.destroy
    redirect_to root_path
  end

  def index
    @blogs = Blog.all
  end

  def new
    @blog = Blog.new
  end

  def create
    @blog = Blog.new(blog_params)
    @blog.user_id = current_user.id
    if @blog.save
      flash[:success] = "Blog wurde erstellt!"
      redirect_to blog_path(@blog)
    else
      render 'new'
    end
  end
end

  def getname(id)
    @user = User.find(id)
    return @user.username
  end

  private

  def blog_params
    params.require(:blog).permit(:name, :description)
  end

  def find_blog
    @blog = Blog.find(params[:id])
  end
