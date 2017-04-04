Rails.application.routes.draw do
  devise_for :identities
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'site#index'
end
