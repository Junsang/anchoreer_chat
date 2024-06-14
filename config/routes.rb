Rails.application.routes.draw do
  get '/signin', to: 'sessions#new'
  post '/signin', to: 'sessions#create'
  delete '/signout', to: 'sessions#destroy'
  
  resources :chats, only: [:create, :index, :show, :update, :destroy] do
    member do
      post 'join_chat'
    end

    resources :messages
      
  end

  resources :users, only: [:index] do
  end

  root 'chats#index'
end
