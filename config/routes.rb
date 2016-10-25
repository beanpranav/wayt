# rubocop:disable Metrics/LineLength
Rails.application.routes.draw do
  resources :friendships

  resources :conversations

  devise_for :users, path: '', path_names: { sign_in: 'login', sign_out: 'logout' },
                     controllers: { registrations: 'registrations' }

  root 'pages#home'
  post 'test_email' => 'pages#test_email'
end
