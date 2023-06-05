Rails.application.routes.draw do
  root "questions#index"

  resources :questions
  resource :session, only: %i[new create destroy]
#   resources :users, only: %i[new create edit update destroy show] do
#     resources :articles do
#       resources :comments
#     end
#   end

  # resources :users, only: %i[new create edit update destroy show]
  resources :users, only: %i[new create edit update destroy show] do
    resources :articles, only: %i[index new edit create show] do
      resources :comments, only: %i[new]
    end
  end

  resources :articles, only: %i[update destroy] do
    resources :comments
  end

# это ан-но таким рутам
# resources :articles do
#   resources :comments, only: [:index, :new, :create]
# end
# resources :comments, only: [:show, :edit, :update, :destroy]

  # resources :users, only: %i[new create edit update destroy show]
  # resources :articles
  # resources :comments, only: [:show, :edit, :update, :destroy]
end
