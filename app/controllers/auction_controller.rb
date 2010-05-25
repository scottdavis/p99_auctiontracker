class AuctionController < ApplicationController
  
  def create
    @auction_data = AuctionParser.from_upload(params[:upload][:log].read)
  end
  
  def index
    unless params.include?(:letter)
      params[:letter] = 'a'
    end
    @letter = params[:letter]
    @items = Item.name_starts_with(params[:letter]).order('name ASC').include(:auctions)
  end
  
  def destroy
    @item = Item.find(params[:id])
    @item.destroy
    redirect_to auction_index_path(:page => params[:page])
  end
  
end
