class Expense
  include Mongoid::Document
  include Mongoid::Timestamps 

  field :name, type: String
  field :amount, type: Float, default: 0.0
  
  belongs_to :user
end
