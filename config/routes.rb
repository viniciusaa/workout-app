Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'registrations' }

  root to: "dashboards#index"

  resources :dashboards, only: [:index] do
    collection do
      post :search, to: "dashboards#search"
    end
  end

  resources :users do
    resources :exercises
  end

  resources :friendships, only: [:show, :create, :destroy]
end
