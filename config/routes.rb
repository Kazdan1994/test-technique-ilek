Rails.application.routes.draw do
  devise_for :experts
  devise_for :users

  root 'wines#search'

  resources :wines, only: %i[search show] do
    resources :reviews, only: %i[show create], param: :wine_id
  end

  resources :reviews, only: %i[show create], param: :wine_id
end
