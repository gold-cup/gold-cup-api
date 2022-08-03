# frozen_string_literal: true

class ApplicationController < ActionController::API
  after_action :add_headers
  def add_headers
    response.headers['Access-Control-Allow-Origin'] = '*'
  end

  def decode_token(header)
    begin
      token = header.split(' ').last
      decoded_token = JWT.decode(token, ENV['APP_SECRET'], true, algorithm: 'HS256')
      payload = decoded_token[0]
      payload
    rescue JWT::DecodeError
      puts "Invalid token"
    end
  end

  def check_if_user_owns_person(request, person_id)
    auth_header = request.headers["Authorization"]
    user_id = decode_token(auth_header)["user_id"]
    person = Person.find(person_id)
    if (person.user_id != user_id)
      render json: {error: "You don't have permission to do that"}, status: 401
    end
  end

  def generate_player_response(player, params)
    payload = {**player.attributes.except("person_id", "team_id")}
    if (params[:include_person] == "true")
      payload["person"] = player.person.attributes
    end
    if (params[:include_team] == "true")
      payload["team"] = player.team.attributes
    end
    payload
  end

  def generate_coach_response(coach)
    payload = {**coach.attributes.except("person_id", "team_id")}
    if (params[:include_person] == "true")
      payload["person"] = coach.person.attributes
    end
    if (params[:include_team] == "true")
      payload["team"] = coach.team.attributes
    end
    payload
  end
end
