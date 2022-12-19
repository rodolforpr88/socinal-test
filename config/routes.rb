Rails.application.routes.draw do
  resources :users do
    resource :role
  end

  resources :tasks do
    resources :executions
  end
end
