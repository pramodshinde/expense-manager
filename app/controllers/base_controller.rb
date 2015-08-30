class BaseController < ApplicationController

  before_action :authenticate!

  X_API_KEY = 'X-Api-Key'

  def current_user
    @current_user
  end

  private
  
  def authenticate!
    begin
      if api_key?
        handler = ApiKeyHandler.new
        claims = handler.decode_api_key(request.headers[X_API_KEY])
        set_current_user(claims[0]['user_id'])
      else
        render_invalid_header
      end
    rescue JWT::ExpiredSignature
      render_expired_message
    rescue JWT::DecodeError
      render_decode_error
    end
  end

  def render_expired_message
    render_message(message: "Api key is expired", info: "Refresh you api key", status: 401)
  end

  def render_invalid_header
    render_message(
      message: "No Authorization key in header", 
      info: "Api key is not provided", 
      status: 401
    )
  end

  def render_decode_error
    render_message(
      message: "Invalid API key", 
      info: "Obtain Api key by login api", 
      status: 401
    )
  end

  def render_message(message:, info: nil, status: 200)
    response_hash = {}
    response_hash[:message] = message
    response_hash[:info] = info if info
    render json: response_hash, status: status
  end

  def render_data(data)
    render json: data
  end

  def api_key?
    request.headers[X_API_KEY].present?
  end

  def set_current_user(user_id)
    @current_user = User.find(user_id)
  end
end
