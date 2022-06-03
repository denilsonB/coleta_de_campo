class UsersController < ApplicationController
  before_action :authorize_request, except: :create

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
    @user = UserServices::CreateUserService.call(user_params[:name],user_params[:password],user_params[:password_confirmation],user_params[:email],user_params[:cpf])
    
    return render json: {errors: @user.errors}, status: :internal_server_error unless @user.success?
    
    render json: @user.result, status: :created
  end

  #PUT /users/id
  def update
    @user = UserServices::UpdateUserService.call(params[:id],user_params)
    
    return render json: {errors: @user.errors}, status: :internal_server_error unless @user.success?
    
    render json: @user.result, status: :ok
  end

  #DELETE /users/{id}
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    render json: {"message":"user deleted with success!"}
  end

  private

  def user_params
    params.permit(
      :name, :email, :password, :password_confirmation, :cpf
    )
  end

end
