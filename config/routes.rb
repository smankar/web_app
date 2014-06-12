WebApp::Application.routes.draw do

  resources :uploads do
    collection { post :import, :as => 'pdf' }
  end

  root :to => 'uploads#index'
end
