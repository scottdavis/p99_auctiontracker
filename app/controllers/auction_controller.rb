class AuctionController < ApplicationController
  
  def create
    @auction_data = AuctionParser.from_upload(params[:upload][:log].read)
  end
  
  def index
    @search = ''
    unless params.include?(:letter)
      params[:letter] = 'a'
    end
    @letter = params[:letter]
    @items = Item.name_starts_with(params[:letter]).order('name ASC').include(:auctions)
  end
  
  def destroy
    @item = Item.find(params[:id])
    @item.destroy
    flash[:notice] = "Item deleted"
    redirect_to auction_index_path(:letter => params[:letter])
  end
  
  def search
    @search = params[:search][:search]
    @items = Item.search_for(params[:search][:search].downcase).order('name ASC').include(:auctions)
    render :action => :index
  end
  
end
