class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy ]
  skip_before_action :require_login, only: [:new, :create]

  # GET /users or /users.json
  def index
    if current_user.admin?
      @users = User.all
    else
      redirect_to '/403'
    end
  end

  # GET /users/1 or /users/1.json
  def show
    redirect_to_403_by_id
  end

  # GET /users/new
  def new
    redirect_to current_user if logged_in?

    @user = User.new
  end

  # GET /users/1/edit
  def edit
    redirect_to_403_by_id
  end

  # POST /users or /users.json
  def create
    @user = User.new(register_params)
    @user.role = 'user'

    respond_to do |format|
      if @user.save
        log_in @user
        format.html { redirect_to '/' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    redirect_to_403_by_id
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: "User was successfully updated." }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    redirect_to_403_by_id
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: "User was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.required(:user).permit(:username, :email, :password)
    end

    def register_params
      params.permit(:username, :email, :password, :password_confirmation)
    end

    def redirect_to_403_by_id
      redirect_to '/403' unless current_user.id == @user.id || current_user.admin?
    end
end
