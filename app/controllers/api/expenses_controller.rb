class Api::ExpensesController < Api::BaseController
  
  def index
    respond_to do |format|
      format.json_v1 { V1::Expenses.new(self).index }
      # If index API is not changed in Version 2
      format.json_v2 { V1::Expenses.new(self).index }
    end
  end

  def show
    respond_to do |format|
      format.json_v1 { V1::Expenses.new(self).show }
      # If index API is changed in Version 2
      format.json_v2 { V2::Expenses.new(self).show }
    end
  end
end