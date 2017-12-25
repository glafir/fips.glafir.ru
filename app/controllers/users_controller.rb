class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
#  after_action :verify_authorized
  def index
    @users = User.all
#    authorize User
  end

  def show
#    authorize @user
  end

  def new
    @user = User.new
 #   authorize @user
  end

  def edit
 #   authorize @user
  end

  def create
    @user = User.new(user_params)
 #   authorize @user
    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
#    authorize @user
    if @user.update_attributes(user_params)
      bypass_sign_in(@user)
      redirect_to users_path, :notice => "User updated!"
    else
      redirect_to users_path, :alert => "Unable to update user."
    end
  end


  def destroy
    user = User.find(params[:id])
#    authorize user
    user.destroy
    redirect_to users_path, :notice => "User deleted."
  end

  # my custom fields are :name,
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:avatar, :username, :password, :password_confirmation, :time_zone, :login, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at, :sign_in_count, :current_sign_in_at, :last_sign_in_at, :current_sign_in_ip, :last_sign_in_ip, :created_at, :updated_at, :email)
    end
end
