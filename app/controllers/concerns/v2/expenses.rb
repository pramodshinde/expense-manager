module V2
  class Expenses < BaseResource
    
    def show
      data = {
        api_version: 2,
        expenses: current_user.expenses.find(params[:id])
      }
      render(data: data)
    end
  end
end