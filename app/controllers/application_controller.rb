# frozen_string_literal: true

class ApplicationController < ActionController::API
  after_action :add_headers
  def add_headers
    response.headers['Access-Control-Allow-Origin'] = '*'
  end

  def decode_token(request)
    begin
      token = request.headers['Authorization'].split(' ').last
      decoded_token = JWT.decode(token, ENV['APP_SECRET'], true, algorithm: 'HS256')
      payload = decoded_token[0]
      payload
    rescue JWT::DecodeError
      puts "Invalid token"
    end
  end

  def check_if_user_owns_person(request, person_id)
    user_id = decode_token(request)["user_id"]
    person = Person.find(person_id)
    if (person.user_id != user_id)
      render json: {error: "You don't have permission to do that"}, status: 401
      return
    end
  end
end
