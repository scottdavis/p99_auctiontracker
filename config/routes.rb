Auctioneer::Application.routes.draw do
  get '/auctions/search' => 'auction#search', :as => 'auction_search'
  resources :auction
  resources :item
  root :to => 'auction#index'

end
