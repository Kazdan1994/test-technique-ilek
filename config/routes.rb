Rails.application.routes.draw do
  devise_for :experts
  devise_for :users

  root 'wines#search'

  resources :wines, only: %i[search show], param: :wine_id do
    resources :reviews, only: %i[show create update]
    get 'reviews', to: 'reviews#show', on: :member, as: 'create_review'
  end
end
