class AuctionController < ApplicationController
  
  def create
    @auction_data = AuctionParser.from_upload(params[:upload][:log].read)
  end
  
  def index
    @items = Item.all(:include => :auctions, :order => 'name ASC').paginate(:per_page => 30, :page => params[:page])
  end
  
  def destroy
    @item = Item.find(params[:id])
    @item.destroy
    redirect_to auction_index_path(:page => params[:page])
  end
  
end
