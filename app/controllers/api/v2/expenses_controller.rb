module Api  
  class V2::ExpensesController < V1::ExpensesController

    def index
      data = { 
        total: current_user.expenses.collect(&:amount).sum,
        expenses: current_user.expenses.all 
      }
      render_data data
    end

    def show
      render_data current_user.expenses.find(params[:id])
    end
  end
end
