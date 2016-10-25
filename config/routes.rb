# rubocop:disable Metrics/LineLength

Rails.application.routes.draw do
  devise_for :users, path: '', path_names: { sign_in: 'login', sign_out: 'logout' }

  root 'pages#home'
  post 'test_email' => 'pages#test_email'
end
