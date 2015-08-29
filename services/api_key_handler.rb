class ApiKeyHandler
  
  def initialize(user: nil)
    @user = user
  end  

  def encoded_api_key
    payload = { exp: 4.week.from_now.to_i, user_id: @user.id.to_s }
    api_key = JWT.encode(payload, Rails.application.secrets.secret_key_base)
  end

  def decode_api_key(api_key)
    ## Sample claims hash 
    # [{"exp"=>1443275296, "user_id"=>"55e1b72e84f16d427a000000"}, {"typ"=>"JWT", "alg"=>"HS256"}]
    JWT.decode(api_key, Rails.application.secrets.secret_key_base, true)
  end
end