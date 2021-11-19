Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :projects, only: %i[create show destroy update ] do
    member do
      patch :complete
    end
    resources :timelapses, only: [:create]
    collection do
      get :clients
    end
  end

  resources :timelapses, only: [:update]
  get 'pages/all_projects', to: 'pages#all_projects', as: :all_projects
  get 'projects/clients/:client', to: 'projects#client_projects', as: :client_projects
  get 'pages/completed_projects', to: 'pages#completed_projects', as: :completed_projects

end
