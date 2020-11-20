Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root 'welcome#say_hi'

  resources :articles, only: %i(index create show update destroy) do
    resources :comments, only: %i[index create show update destroy]
  end
end
