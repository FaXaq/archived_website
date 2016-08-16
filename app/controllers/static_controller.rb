class StaticController < ApplicationController
  def blog
    if params[:search] != nil && params[:search] != ""
      @posts = Post.search(params[:search]).paginate(:page => params[:page], :per_page => 15).order('updated_at DESC')
      @search_param = params[:search]
    elsif logged_in?
      @posts = Post.paginate(:page => params[:page], :per_page => 15)
    else
      @posts = Post.where(published: true).paginate(:page => params[:page], :per_page => 15)
    end
  end

  def index
  end

  def aboutme
  end

  def contact
    @name = ""
    @body = ""
    @email = ""
    @errors = Array.new()
  end

  def send_contact_email
    @name = params[:name]
    @body = params[:body]
    @email = params[:email]
    @captcha = params[:"g-recaptcha-response"]
    @errors = Array.new()
    if @captcha == nil || @captcha == ""
      @errors.push("Captcha not filled")
    end
    if @name == nil || @name == ""
      @errors.push("Name cannot be blank, please fill your name")
    end
    if @email == nil || @email == "" || @email.match(/\A([\w+\-]\.?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i) == false
      @errors.push("Enter a valid email")
    end
    if @body == nil || @body == "" || @body.size < 100
      @errors.push("Body cannot be blank or less than 100 chars")
    end
    if @errors.count > 0
      flash[:error] = 'Error while sending contact form'
      render 'contact'
    else
      if Contact.email(@name, @email, @body).deliver_now
        flash[:success] = 'Mail sent to Marin'
        flash[:info] = 'Thanks for the kind (I presume) words ! I\'ll be back at your when I can.'
        redirect_to root_url
      else
        flash[:info] = "Infos are good but mail didn't reach the destination"
        render 'contact'
      end
    end
  end
end
