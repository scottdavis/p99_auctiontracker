Auctioneer::Application.routes.draw do
  resources :item_aliases

  get '/auctions/search' => 'auction#search', :as => 'auction_search'
  resources :auction
  resources :item
  resources :logs
  root :to => 'auction#index'

end
