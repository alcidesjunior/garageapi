Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      post 'user_token' => 'user_token#create'
      resources :users
      resources :addresses
      resources :comments
      get 'garageComments/:garage_id', to: 'comments#comments'
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
