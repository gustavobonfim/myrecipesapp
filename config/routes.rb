Rails.application.routes.draw do


  root 'pages#home'
  get '/about', to: 'pages#about'

  get '/order', to: 'pages#order'
  get '/dashboard', to: 'pages#dashboard'

  # get '/recipes', to: 'recipes#index'
  # get 'recipes/new', to: 'recipes#new', as: 'new_recipe'
  # post '/recipes', to: 'recipes#create'
  # get '/recipes/:id', to: 'recipes#show', as: 'recipe'


  resources :recipes do
    resources :comments, only: [:create]
  end

  get '/signup', to: 'chefs#new', as: 'signup'
  resources :chefs, except:[:new]

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  resources :ingredients, except:[:destroy]



  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
