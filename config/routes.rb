Rails.application.routes.draw do
  if Rails.env.development?
    mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "graphql#execute"
  end
  post "/graphql", to: "graphql#execute"

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
