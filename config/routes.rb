Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users, only: [] do
    collection do
      get :register
      get :login
      post :user_login
      post :user_register
      get  :logout
    end
  end
  root 'users#login'
end
