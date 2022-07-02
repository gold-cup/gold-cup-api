class ApplicationController < ActionController::API
  after_action :add_headers
  def add_headers
    response.headers['Access-Control-Allow-Origin'] = '*'
  end
end
