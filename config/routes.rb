Rails.application.routes.draw do
  resources :people 
  get 'more_info', to: 'people#more'

  devise_for :users
  root to: 'people#index'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
