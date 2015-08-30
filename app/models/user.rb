class User
  include Mongoid::Document

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :validatable

  ## Database authenticatable
  field :email,              type: String, default: ""
  field :encrypted_password, type: String, default: ""
  field :api_daily_limit,     type: String, default: 5  

  has_many :expenses

  def generate_api_key
    handler = ApiKeyHandler.new(user: self) 
    handler.encoded_api_key
  end
end
