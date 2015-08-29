class V1::ExpensesController < V1::BaseController
  
  def index
    render_data current_user.expenses.all
  end

  def show
    render_data current_user.expenses.find(params[:id])
  end

  def create
    expense = current_user.expenses.where(name: exp_params[:name]).first
    unless expense.present?
      expense = current_user.expenses.new(exp_params)      
      if expense.save
        render_message(message: "Expense added successfully")
      else
        render_message(
          message: "Error in creating expense", 
          info: expense.errors.full_messages,
          status: 422
        )
      end
    else
      render_message(message: "Expense already exists")
    end
  end

  private

  def exp_params
    params.require(:expense).permit(:name, :amount) 
  end
end
