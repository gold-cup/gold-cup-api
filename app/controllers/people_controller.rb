class PeopleController < ApplicationController
  def create
    token_from_request = request.headers["Authorization"]
    user_id = decode_token(token_from_request)["user_id"]
    person = Person.new(person_params.merge(user_id: user_id, status: "pending"))
    if (person.save)
      render json: person, status: 201
    else
      render json: {errors: person.errors}, response: 422
    end
  end

  def update
    check_if_user_owns_person
    person = Person.find(params[:id])
    if (person.update(person_params))
      render json: person, status: 200
    else
      render json: {errors: person.errors}, response: 422
    end
  end

  def destroy
    check_if_user_owns_person
    person = Person.find(params[:id])
    destroyed_person = person.destroy
    if destroyed_person.destroyed?
      render json: {message: "Person removed"}, status: 200
    else
      render json: {errors: person.errors}, response: 422
    end
  end

  def show
    check_if_user_owns_person
    person = Person.find(params[:id])
    render json: person, status: 200
  end

  private

  def person_params
    params.permit(
      :first_name,
      :last_name,
      :middle_name,
      :city,
      :province,
      :country,
      :email,
      :birthday,
      :gender,
      :phone_number,
      :waiver,
      :photo,
      :gov_id,
      :parent_email
    )
  end

  def decode_token(token)
    begin
      encoded_token = token
      puts encoded_token
      if (encoded_token)
        token = encoded_token.split(' ').last
        decoded_token = JWT.decode(token, ENV['APP_SECRET'], true, algorithm: 'HS256')
        payload = decoded_token[0]
        payload
      else
        puts "No token found"
      end
    rescue JWT::DecodeError
      puts "Invalid token"
    end
  end

  def check_if_user_owns_person
    token_from_request = request.headers["Authorization"]
    user_id = decode_token(token_from_request)["user_id"]
    person = Person.find(params[:id])
    if (person.user_id != user_id)
      render json: {error: "You don't have permission to do that"}, status: 401
      return
    end
  end

  def check_if_user_owns_person_params
    token_from_params = params[:token]
    user_id = decode_token(token_from_params)["user_id"]
    person = Person.find(params[:id])
    if (person.user_id != user_id)
      render json: {error: "You don't have permission to do that"}, status: 401
      return
    end
  end
end
