Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :users do
    resources :visits do
      post 'checkin', on: :member
      post 'checkout', on: :member
    end
  end
  resources :formularies do
    resources :questions do
      resources :answers, only: %i[index create update destroy]
    end
  end
  
  post '/auth/login', to: 'authentication#login'
end
