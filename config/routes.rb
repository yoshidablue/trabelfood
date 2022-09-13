Rails.application.routes.draw do

  devise_for :customers, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

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
    get "search_tag" => "posts#search_tag"
  end



  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
