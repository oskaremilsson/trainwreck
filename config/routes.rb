Rails.application.routes.draw do
  get 'welcome/index'

  resources :courses

  get 'login', to: 'login#index'
  get 'logout', to: 'login#logout', as: :logout
  post 'login', to: 'login#login'

  root 'welcome#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
