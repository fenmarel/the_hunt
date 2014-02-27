TheHunt::Application.routes.draw do
  resources :users do
    resources :job_applications, :except => [:show, :index], :shallow => true do
      post :denied, :on => :member
      post :renew, :on => :member
    end
    get :rejections, :on => :member
  end

  resource :session, :only => [:new, :create, :destroy]

end
