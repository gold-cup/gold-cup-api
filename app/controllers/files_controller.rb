class FilesController < ApplicationController
  def create_token
    user_id = params[:user_id]
    type = params[:type]
    payload = { user_id: user_id, type: type }
    token = JWT.encode payload, ENV['APP_SECRET'], 'HS256'
    render json: { token: token }, response: 200
  end

  def get_file
    encoded_token = params[:token]
    decoded_token = JWT.decode encoded_token, ENV['APP_SECRET'], true, algorithm: 'HS256'
    puts decoded_token
    type = decoded_token[0]['type']
    id = decoded_token[0]['user_id']
    person = Person.find(id)
    if type == 'waiver'
      binary_data = person.waiver.download
      send_data binary_data, filename: person.waiver.filename.to_s, type: person.waiver.content_type.to_s, disposition: 'attachment'
    elsif type == 'photo'
      binary_data = person.photo.download
      send_data binary_data, filename: person.photo.filename.to_s, type: person.photo.content_type.to_s, disposition: 'attachment'
    elsif type == 'gov_id'
      binary_data = person.gov_id.download
      send_data binary_data, filename: person.gov_id.filename.to_s, type: person.gov_id.content_type.to_s, disposition: 'attachment'
    else
      render json: {error: "Invalid type"}, status: 422
    end
  end


end
