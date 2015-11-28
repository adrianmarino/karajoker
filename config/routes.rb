require 'sidekiq/web'

Rails.application.routes.draw do
  root 'application#index'

  mount API => '/'

  mount Sidekiq::Web, at: '/sidekiq'
end
