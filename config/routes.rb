ButcherShop::Application.routes.draw do
  resources :animals, :except => [:new, :edit] do
    resources :primal_cuts, :only => [:index, :create]
    resources :cuts,        :only => [:index, :create]
  end

  resources :primal_cuts, :only => [:show, :update, :destroy] do
    resources :cuts, :only => [:index, :create]
  end

  resources :cuts, :only => [:show, :update, :destroy]

  resources :users, :except => [:new, :edit] do
    resources :favorites, only: [:index, :create]
  end

  resources :favorites, only: [:show, :update, :destroy]
end
