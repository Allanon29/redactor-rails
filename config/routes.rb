RedactorRails::Engine.routes.draw do
  resources :pictures,  :only => [:index, :create, :delete, :destroy]
  resources :documents, :only => [:index, :create]
end
