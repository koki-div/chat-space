Rails.application.routes.draw do
  devise_for :users
  root "groups#index"
  resources :users, only:[:index, :edit, :update]            # :index -> ajax用
  resources :groups, only:[:new, :create, :edit, :update] do
    # :index ->  投稿メッセージの一覧表示 & メッセージ入力
    # :create -> メッセージの保存
    
    # controllers/messages_controller.rb の作成に伴うルーティング
    resources :messages, only: [:index, :create]

    # controllers/api/messages_controller.rb の作成に伴うルーティング
    namespace :api do
      resources :messages, only: :index, defaults: { format: 'json' }
    end
  end
end
