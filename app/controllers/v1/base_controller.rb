class V1::BaseController < ApplicationController
  before_action :authenticate!

  X_API_KEY = 'X-Api-Key'

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
    rescue JWT::DecodeError
      render_decode_error
    rescue JWT::ExpiredSignature
      render_expired_message
    end
  end

  def current_user
    @current_user
  end

  def render_expired_message
    render_response(message: "Api key is expired", info: "Refresh you api key")
  end

  def render_invalid_header
    render_response(message: "No Authorization key in header", info: "Api key is not provided")
  end

  def render_response(message:, info: nil, status: 401)
    response_hash = {}
    response_hash[:message] = message
    response_hash[:info] = info if info
    render json: response_hash, status: status
  end

  def api_key?
    request.headers[X_API_KEY].present?
  end

  def set_current_user(user_id)
    @current_user = User.find(user_id)
  end
end