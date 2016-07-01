class StaticController < ApplicationController
  def blog
    if params[:search] != nil
      @posts = Post.search(params[:search])
      @search_param = params[:search]
    elsif logged_in?
      @posts = Post.last(5)
    else
      @posts = Post.where(published: true).last(5)
    end
  end

  def index
  end

  def aboutme
  end

  def allposts
    if logged_in?
      @posts = Post.all.paginate(:page => params[:page], :per_page => 30)
    else
      @posts = Post.where(published: true).paginate(:page => params[:page], :per_page => 30)
    end
  end
end
