Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :pages, only: [:create]
  resources :projects, only: %i[show destroy] do
    resources :timelapses, only: [:create]
  end

  resources :timelapses, only: [:update]
end
