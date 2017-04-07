Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "omniauth_callbacks" }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'site#index'

  resources :users do
    resources :topics, shallow: true
  end

  resources :topics do
    resources :insights, only: [:create, :update]
  end

end
