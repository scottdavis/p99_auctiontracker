Auctioneer::Application.routes.draw do

  resources :auction
  resources :item
  get '/auctions/search' => 'auction#search', :as => 'auction_search'
  root :to => 'auction#index'

end
