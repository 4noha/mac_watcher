Rails.application.routes.draw do
  root 'tops#index'
  
  resources :tops do
  end
end
