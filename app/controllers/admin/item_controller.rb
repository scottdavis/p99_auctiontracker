class Admin::ItemController < ApplicationController
  
  
  
  def index
    @items = Item.all.flagged
  end
  
  
  def update
    @item = Item.find(params[:id])
    @item.show! if params[:unhide]
    @item.unflag! if params[:unflag]
    @item.hide! if params[:hide]
    redirect_to :back  
  end
  
  
  
end
