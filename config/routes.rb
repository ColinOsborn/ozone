Rails.application.routes.draw do
  # get 'home/zipcode'
  root 'home#index'

  post "zipcode" => "home#zipcode"
end
