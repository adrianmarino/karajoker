Rails.application.routes.draw do
  root 'application#index'
  mount API => '/'
end
