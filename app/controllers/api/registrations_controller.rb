class Api::RegistrationsController < Api::BaseController
  skip_before_action :authenticate!

  def create
    @user = User.new(user_params)
    sign_up
  end

  private

  def sign_up
    if @user.save
      data = { email: @user.email, api_key: @user.generate_api_key }
      render_data(data)
    else
      render_error
    end
  end

  def render_error
    render_message( 
      message: "Error in sign up", 
      info: @user.errors.full_messages, 
      status: 422   
    )
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
