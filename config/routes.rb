Rails.application.routes.draw do
  root "home#index"
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, controllers:{omniauth_callbacks: "users/omniauth_callbacks"}
  resources :users, only: %i(index show destroy) do
    resources :schedules, only: %i(index create destroy) do
      resources :schedule_items, only: %i(index destroy edit create)
    end
  end
  get "/search", to: "home#search"
  get "services", to: "services#index"
  get "services/categories/:category_id", to: "services#index", :as => :service_categories
  get "services/:id/book" , to: "services#book", :as => :service_book
  get "services/:id/payment" , to: "services#payment", :as => :service_payment
  get "services/:id/confirm" , to: "services#confirm", :as => :service_confirm
  get "services/:id" , to: "services#show", :as => :service_details
  post "services/:id/save/info", to: "services#save_info", :as => :service_save_info
  get "services/:id" , to: "services#show", :as => :service_details
  resources :service_reviews, only: %i(create destroy)
end
