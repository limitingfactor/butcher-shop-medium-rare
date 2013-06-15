ButcherShop::Application.routes.draw do

  resources :animals, :except => [:new, :edit] do
    resources :primal_cuts, :only => [:index, :create]
    resources :cuts,        :only => [:index, :create]
  end

  resources :primal_cuts, :only => [:show, :update, :destroy] do
    resources :cuts, :only => [:index, :create]
  end

  resources :cuts, :only => [:show, :update, :destroy]
end
