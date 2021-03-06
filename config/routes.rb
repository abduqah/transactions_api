Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  namespace :api, defaults: { format: 'json'} do
    resources :transactions, only: %i[index show create update]
  end
end
