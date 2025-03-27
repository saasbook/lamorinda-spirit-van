# frozen_string_literal: true

class Admin::UsersController < ApplicationController
  before_action :require_admin

  def index
    @users = User.all
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to admin_users_path, notice: "User updated successfully."
    else
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to admin_users_path, notice: "User deleted successfully."
  end

  private
  def require_admin
    redirect_to root_path, alert: "Access denied." unless current_user.admin?
  end

  def user_params
    params.require(:user).permit(:role)
  end
end
