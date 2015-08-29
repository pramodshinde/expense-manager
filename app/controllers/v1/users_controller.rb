class V1::UsersController < V1::BaseController
  skip_before_action :authenticate!, only: :login 

  def login
    user_params = params[:user]
    user = User.where(email: user_params[:email]).first
    unless user and user.valid_password?(user_params[:password])
      render_response(message: "Invalid email or password")
    else
      render json: { email: user.email, api_key: user.generate_api_key }
    end
  end

  def index
    render json: current_user
  end
end
