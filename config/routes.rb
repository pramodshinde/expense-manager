Rails.application.routes.draw do
      
  namespace :api do   
    resources :expenses
    post :registrations, to: 'registrations#create'
  
    resources :users do
      collection do
        post :login
      end
    end
  end
end