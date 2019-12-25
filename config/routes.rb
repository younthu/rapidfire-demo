Rails.application.routes.draw do
  devise_for :users
  mount Rapidfire::Engine => "/rapidfire" do
  end
  root 'home_page#index'
end
