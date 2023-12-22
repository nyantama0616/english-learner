Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  namespace :v1 do
    get "devs/ping", to: "devs#ping"
    resources :words, only: [:index]
  end
end
