class AuctionController < ApplicationController
  
  def create
    @item = Item.find_or_create_by_name(params[:item].downcase)
    auction = Auction.new
    auction.item = @item
    if params[:price].include?('k')
      params[:price] = params[:price].to_f * 1000
    end
    auction.price = params[:price].to_i
    auction.time = Time.parse params[:time]
    if auction.save
      render :text => true, :layout => false
    else
      render :text => auction.errors.map(&:to_s).join(", ")
    end
  end
  
  
end
