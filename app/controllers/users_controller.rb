require 'jwt'

class UsersController < ApplicationController
  def create
    puts user_params
    user = User.new(user_params)
    if user.save
      token = generate_token(user)
      render json: {user: user, token: token}, response: 201
    else
      render json: {errors: user.errors}, response: 422
    end
  end

  def show
    begin
      user_id_from_token = decode_token(request)["user_id"]
      puts user_id_from_token
      if user_id_from_token == params[:id].to_i
        user = User.find(params[:id])
        render json: filter_response(user), status: :ok
      else
        render json: {error: 'You must be logged in to view this user'}, status: :unauthorized
      end
    rescue JWT::VerificationError, JWT::DecodeError
      render json: {error: 'failed to decode token'}, status: :unauthorized
    end
  end


  def login
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      generate_token(user)
      render json: {**user.attributes, token: token}, status: :ok
    else
      render json: { error: 'Invalid username or password' }, status: :unauthorized
    end
  end

  private
  def user_params
    params.permit(:name, :email, :password)
  end

  def generate_token(user)
    payload = { user_id: user.id }
    token = JWT.encode payload, ENV['APP_SECRET'], 'HS256'
  end

  def decode_token(request)
    token = request.headers['Authorization'].split(' ').last
    begin
      decoded_token = JWT.decode(token, ENV['APP_SECRET'], true, algorithm: 'HS256')
      payload = decoded_token[0]
      payload
    rescue JWT::DecodeError
      puts "Invalid token"
    end
  end

  def filter_response(user)
    user.attributes.except("password_digest")
  end

end
