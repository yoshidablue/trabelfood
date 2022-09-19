Rails.application.routes.draw do

  devise_for :customers, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  devise_scope :customer do
    post 'customers/guest_sign_in', to: 'public/sessions#guest_sign_in'
  end

  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }

  scope module: :public do
    root "homes#top"
    get "about" => "homes#about"
    resources :customers, only: [:show, :index, :edit, :update] do
      resource :relationships, only: [:create, :destroy]
      get 'followings' => 'relationships#followings', as: 'followings'
      get 'followers'  => 'relationships#followers',  as: 'followers'
      get "unsubscribe" => "customers#unsubscribe", as: "unsubscribe"
      patch "withdraw" => "customers#withdraw", as: "withdraw"
      member do
        get 'favorites'
      end
    end
    resources :posts, only: [:show, :index, :create, :new, :edit, :update, :destroy] do
      resources :food_comments, only: [:create, :destroy]
      resource  :favorites,     only: [:create, :destroy]
      collection do
        get 'search'
      end
    end
    resources :rooms,    only: [:create, :show, :index]
    resources :messages, only: [:create]
    resources :groups do
      resources :group_comments, only: [:create, :destroy]
      get "join" => "groups#join"
      delete "all_destroy" => "groups#all_destroy"
    end
    get "search_tag" => "posts#search_tag"
  end

  namespace :admin do
    resources :customers, only: [:show, :index, :edit, :update]
    resources :posts,     only: [:show, :index, :destroy] do
      resources :food_comments, only: [:destroy]
    end
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
