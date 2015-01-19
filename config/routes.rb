Orden::Application.routes.draw do


  devise_for :users
  resources :tasks

  root :to => "pages#home"

end