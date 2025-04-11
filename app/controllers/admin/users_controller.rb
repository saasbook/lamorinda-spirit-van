# frozen_string_literal: true

class Admin::UsersController < ApplicationController
  before_action -> { require_role("admin") }

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
    if @user.destroy
      redirect_to admin_users_path, notice: "User deleted successfully."
    else
      redirect_to admin_users_path, alert: @user.errors.full_messages.to_sentence
    end
  end

  private
  def user_params
    permitted = [:email, :password]
    # Allow admin to update role, but regular users can only update email and password
    permitted << :role if current_user&.admin?
    params.require(:user).permit(permitted)
  end
end
