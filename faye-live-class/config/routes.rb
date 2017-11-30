Rails.application.routes.draw do
  devise_scope :user do
    root to: "devise/sessions#new"
  end
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # root "answers#index"

  resources :answers
  resources :exams
  resources :questions
  resources :next_pages
  namespace :api do
    namespace :v1 do
      resources :exams
      resources :questions
    end
  end
end
