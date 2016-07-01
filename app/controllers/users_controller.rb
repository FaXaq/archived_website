class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def edit
  end

  def edit_password
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to root_url
    else
      redirect_to root_url
    end
  end

  def update
  end

  private
  def user_params
    params.require(:user).permit(:firstname, :lastname, :email,
                                 :password, :password_confirmation)
  end
end
