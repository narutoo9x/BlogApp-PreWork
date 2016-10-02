Rails.application.routes.draw do
  resources :articles do
    member do
      put "like", to: "articles#upvote"
    end
    resources :comments
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'articles#index'
end
