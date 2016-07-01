# coding: utf-8
class PostsController < ApplicationController
  def show
    current_user
    post = Post.find_by(slug: params[:slug])
    if post == nil
      render_404
    end
    if post.published === true
      @post = post
    elsif logged_in?
      @post = post
    else
      render_403
    end
  end

  def new
    if logged_in?
      @post = Post.new
    else
      redirect_to root_url
    end
  end

  def create
    if logged_in?
      @post = Post.new(post_params)
      @post.slug = @post.title.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')
      if @post.save
        redirect_to "/posts/" + @post.slug
      else
        render 'new'
      end
    end
  end

  def edit
    @post = Post.find_by(slug: params[:slug])
    if logged_in?
      render 'edit'
    else
      redirect_to "/posts/" + @post.slug
    end
  end

  def update
    if logged_in?
      @post = Post.find_by(slug: params[:slug])
      @post.slug = @post.title.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')
      if @post.update(post_params)
        @post.slug = @post.title.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')
        if @post.update(post_params)
          redirect_to "/posts/" + @post.slug
        end
      else
        render 'edit'
      end
    end
  end

  def destroy
    @post = Post.find_by(slug: params[:slug])
    @post.destroy
    redirect_to root_url
  end

  private
  def post_params
    params.require(:post).permit(:id ,:title, :description, :content, :published)
  end
end
