Rails.application.routes.draw do
  resources :signatures, only: [:create] do
    get :count, on: :collection
  end

  resources :legislators, only: [:show] do
    post :call, on: :member
  end

  resources :calls, only: [:create, :update] do
    member do
      post :end
      get :progress
    end
  end

  get "/legislators/lookup", to: "legislators#show"
  root to: "pages#home"
end
