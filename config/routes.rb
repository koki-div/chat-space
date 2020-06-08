Rails.application.routes.draw do
  devise_for :users
  root "groups#index"
  resources :users, only:[:index, :edit, :update]            # :index -> ajax用
  resources :groups, only:[:new, :create, :edit, :update] do
    # :index ->  投稿メッセージの一覧表示 & メッセージ入力
    # :create -> メッセージの保存
    resources :messages, only: [:index, :create]
  end
end
