Rails.application.routes.draw do
  resource :wechat, only: [:show, :create]
  devise_for :users
  mount Rapidfire::Engine => "/rapidfire" do
  end
  root 'home_page#index'
end
