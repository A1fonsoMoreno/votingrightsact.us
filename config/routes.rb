Rails.application.routes.draw do
  resources :signatures, only: [:create]

  root to: "pages#home"
end
