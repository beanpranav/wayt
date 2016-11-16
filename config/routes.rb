# rubocop:disable Metrics/LineLength
Rails.application.routes.draw do
  resources :friendships, path: 'close_friends' do
    member do
      post :accept
    end
  end

  resources :comments
  resources :conversations

  resources :participations do
    member do
      post :mark_as_unread
      post :mark_as_read
      post :unmute
      post :mute
    end
  end

  devise_for :users, path: '', path_names: { sign_in: 'login', sign_out: 'logout' },
                     controllers: { registrations: 'registrations' }
  devise_scope :user do
    post 'toggle_friendship_notification', action: 'toggle_friendship_notification', controller: 'registrations'
    post 'toggle_conversation_notification', action: 'toggle_conversation_notification', controller: 'registrations'
    post 'toggle_reply_notification', action: 'toggle_reply_notification', controller: 'registrations'
  end

  get 'notification_settings' => 'pages#notification_settings'
  root 'pages#home'
end
