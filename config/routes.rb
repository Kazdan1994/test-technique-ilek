Rails.application.routes.draw do
  devise_for :experts
  devise_for :users

  root 'wines#search'

  resources :wines, only: %i[search show] do
    resources :reviews, only: %i[show create update]
    get   'reviews', to: 'reviews#show', param: :wine_id, as: 'show_review'
    post  'reviews', to: 'reviews#create', on: :member, as: 'create_review'
    patch 'reviews', to: 'reviews#update', on: :member, as: 'update_review'
  end

  resources :searches, only: :index
end
