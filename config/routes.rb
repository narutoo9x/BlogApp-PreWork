Rails.application.routes.draw do
  resources :articles do
    collection do
      get 'search'
    end
    member do
      put "like", to: "articles#upvote"
      # put "dislike", to: "articles#downvote"
    end
    resources :comments
  end
  get 'tags/:tag' , to: 'articles#index', as: "tag"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'articles#index'
end
