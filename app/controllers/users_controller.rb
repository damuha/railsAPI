class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]

  # GET /users
  def index
    @users = User.joins(:tickets)
    .select("
      id AS ticket_id, 
      ticket_name, 
      users.user_id,
      user_name, 
      give_user_id
      ")


    render json: @users
  end

  # GET /users/1
  def show
    @user = User.joins(:tickets)
    .select("
      id AS ticket_id, 
      ticket_name, 
      users.user_id,
      user_name, 
      give_user_id
      ")
      .where(
        user_id: params[:id]
      )

    render json: { status: 'SUCCESS', message: 'Loaded the post', data: @user }
  end
  # POST /users
  def create
    @user = User.new(user_params)

    if @user.save
      render json: @user, status: :created, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find_by(user_id: params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def user_params
      params.fetch(:users, {})
      params.fetch(:users, {}).permit(:user_name)
    end

end
