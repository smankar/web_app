WebApp::Application.routes.draw do


  #get "uploads/new"

  resources :uploads do
    collection { post :import }
  end

  root :to => 'uploads#index'
end
