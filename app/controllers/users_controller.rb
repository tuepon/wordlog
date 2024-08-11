class UsersController < ApplicationController
  before_action :set_user, only: [:show]

  def index
    if params[:search_query].present?
      @users = User.where('username LIKE ?', "%#{params[:search_query]}%")
    else
      @users = []
    end

    if turbo_frame_request?
      render partial: "layouts/search_results", locals: {users: @users}
    end
  end

  def show
  end

  private

  def set_user
    @user = User.find_by(id: params[:id])
    unless @user
      flash[:alert] = "User not found"
      redirect_to root_path
    end
  end
end
