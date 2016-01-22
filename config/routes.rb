Rails.application.routes.draw do

  devise_scope :user do
    authenticated :user do
      root 'users#index', as: :authenticated_root
    end

    unauthenticated do
      root 'devise/sessions#new', as: :unauthenticated_root
    end
  end

  devise_for :users

  resources :po_boxes

  resources :users, only: [:index, :show, :activate]  do
    put "activate" => "users#activate", as: "activate"
    put "text_message_send" => "users#text_message_send", as: "text_message_send"
  end

  resources :admin, only: [:create, :new, :update, :destroy, :edit, :index]


  ### API ###
  namespace :api, :path => "", :constraints => {:subdomain => "api"}, :defaults => {:format => :json} do
    namespace :v1 do
      resources :users
    end
  end
end
