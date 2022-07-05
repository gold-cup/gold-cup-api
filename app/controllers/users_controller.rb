require 'jwt'

class UsersController < ApplicationController
  def create
    @user = User.new(user_params)
    if @user.save
      render json: @user, status: :created
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def login
    puts ENV['APP_SECRET']
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      payload = { user_id: user.id }
      token = JWT.encode payload, ENV['APP_SECRET'], 'HS256'
      render json: {**user.attributes, token: token}, status: :ok
    else
      render json: { error: 'Invalid username or password' }, status: :unauthorized
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password)
  end
end
