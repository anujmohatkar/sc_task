Rails.application.routes.draw do
  resources :tasks
  root 'home#index'
  get 'home/index'
  devise_for :users , controllers: { registrations: 'users/registrations' }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  namespace 'api' do
    post 'max_sum', action: :max_sum, controller: 'maths'
  end

  # route for any non-existing route
  match '*path', to: 'home#not_found', via: :all
end
