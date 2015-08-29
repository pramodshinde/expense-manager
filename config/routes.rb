Rails.application.routes.draw do
  
  api_version(:module => "V2", :header => {:name => "Accept", :value => "application/vnd.expense-manager; version=1"}) do
    resources :expenses
    post :registrations, to: 'registrations#create'
  
    resources :users do
      collection do
        post :login
      end
    end
  end
  
  api_version(:module => "V1", :header => {:name => "Accept", :value => "application/vnd.expense-manager; version=1"}) do
    resources :expenses
    post :registrations, to: 'registrations#create'
  
    resources :users do
      collection do
        post :login
      end
    end
  end
end
