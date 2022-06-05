class UsersController < ApplicationController
  unless Rails.env.test?
    before_action :authorize_request, except: :create
  end

  #GET /users
  def index
    @users = User.all
    render json: @users, status: :ok
  end

  #GET /users/{id}
  def show
    @user = User.find(params[:id])
    render json: @user, status: :ok
  end

  #POST /users
  def create
    @service = UserServices::Create.call(user_params)
    render_service
  end

  #PUT /users/id
  def update
    @service = UserServices::Update.call(params[:id],user_params)
    render_service
  end

  #DELETE /users/{id}
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    render json: {"message":"user deleted with success!"}
  end

  private

  def render_service
    if @service.success?
      render json: @service.result, status: :ok
    else
      render json: {  **@service.errors }, status: :unprocessable_entity
    end
  end

  def user_params
    params.permit(
      :name, :email, :password, :password_confirmation, :cpf
    )
  end

end
