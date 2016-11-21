class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def new
    # Only existing users can create new users
    unless logged_in?
      render :file => 'public/401', :status => :unauthorized, :layout => false and return
    end

    @user = User.new
  end
  def create
    # Only existing users can create new users
    unless logged_in?
      render :file => 'public/401', :status => :unauthorized, :layout => false and return
    end

    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "Welcome, new user!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def show
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
