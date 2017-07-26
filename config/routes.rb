Rails.application.routes.draw do


  root 'pages#home'
  get '/about', to: 'pages#about'

  get '/order', to: 'pages#order'

  # get '/recipes', to: 'recipes#index'
  # get 'recipes/new', to: 'recipes#new', as: 'new_recipe'
  # post '/recipes', to: 'recipes#create'
  # get '/recipes/:id', to: 'recipes#show', as: 'recipe'


  resources :recipes

  get '/signup', to: 'chefs#new', as: 'signup'
  resources :chefs, except:[:new]




  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
