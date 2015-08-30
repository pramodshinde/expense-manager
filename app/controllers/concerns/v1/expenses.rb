module V1
  class Expenses < BaseResource
    
    def index
      render(data: current_user.expenses.all)
    end

    def show
      render(data: current_user.expenses.find(params[:id]))
    end

    def create
      expense = current_user.expenses.where(name: exp_params[:name]).first
      unless expense.present?
        expense = current_user.expenses.new(exp_params)      
        if expense.save
          render(data: { message: "Expense added successfully" })
        else
          render(data: { message: "Error in creating expense"}, status: 422)
        end
      else
        render(data: { message: "Expense already exists"})
      end
    end

    private

    def exp_params
      params.require(:expense).permit(:name, :amount) 
    end
  end
end