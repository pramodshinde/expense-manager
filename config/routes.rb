Rails.application.routes.draw do
  
  ## API Routes
  # Version 2
  namespace :api do
    api_version(
      :module => "V2", 
      :header => {:name => "Accept", :value => "application/vnd.expense-manager; version=2"}
    ) do
      resources :expenses
      post :registrations, to: 'registrations#create'
    
      resources :users do
        collection do
          post :login
        end
      end
    end
  end
    
  ## API Routes
  # Version 1
  namespace :api do 
    api_version(
      :module => "V1", 
      :header => {:name => "Accept", :value => "application/vnd.expense-manager; version=1"}
    ) do    
      resources :expenses
      post :registrations, to: 'registrations#create'
    
      resources :users do
        collection do
          post :login
        end
      end
    end
  end
end
