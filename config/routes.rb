Orden::Application.routes.draw do


  devise_for :users
  resources :tasks do
  	get 'complete'
  end

  root :to => "pages#home"

end