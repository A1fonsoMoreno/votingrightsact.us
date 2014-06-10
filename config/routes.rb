Rails.application.routes.draw do
  resources :signatures, only: [:create]
  resources :legislators, only: [:show]

  get "/legislators/lookup", to: "legislators#show"
  root to: "pages#home"
end
