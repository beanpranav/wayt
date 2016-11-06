# rubocop:disable Metrics/LineLength
Rails.application.routes.draw do
  resources :friendships, path: 'close_friends' do
    member do
      post :accept
    end
  end

  resources :comments
  resources :conversations, path: 'discussions'

  resources :participations do
    member do
      post :mark_as_unread
      post :mark_as_read
    end
  end

  devise_for :users, path: '', path_names: { sign_in: 'login', sign_out: 'logout' },
                     controllers: { registrations: 'registrations' }

  root 'pages#home'
  get 'friends' => 'pages#friends'
end
