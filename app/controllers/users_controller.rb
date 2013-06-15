class UsersController < ApplicationController
  respond_to :json

  before_filter :find_user, :except => [:index, :create]

  def index
    @users = User.all
    respond_with @users
  end

  def create
    @user = User.create user_params
    respond_with @user
  end

  def show
    respond_with @user
  end

  def update
    @user.update_attributes user_params
    respond_with @user
  end

  def destroy
    @user.destroy
    head 204
  end

  protected
    def find_user
      @user = User.find params[:id]
    rescue ActiveRecord::RecordNotFound
      head 404
    end

    def user_params
      params.require(:user).permit(:first_name, :last_name, :email)
    end
end
