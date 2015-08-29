class V1::UsersController < V1::BaseController
  skip_before_action :authenticate!, only: :login 

  def login
    user_params = params[:user]
    user = User.where(email: user_params[:email]).first
    unless user and user.valid_password?(user_params[:password])
      render_message(message: "Invalid email or password", status: 401)
    else
      data = { email: user.email, api_key: user.generate_api_key }
      render_data(data)
    end
  end

  def expenses
    render_data current_user.expenses
  end
end
