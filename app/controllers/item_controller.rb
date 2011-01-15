class ItemController < ApplicationController
  
  def destroy
    @item = Item.find(params[:id])
    #@item.hide!
    flash[:notice] = "Item deleted"
    expire_page :action => "show", :id => params[:id]
    redirect_to auction_index_path(:letter => params[:letter])
  end
  
  def show
    expires_in(1.minutes)
    @item = Item.find(params[:id])
    @auctions = @item.auctions.not_hidden.order('time ASC')#.paginate(:page => params[:page], :per_page => 25, :order => 'time DESC')
    @vector = @auctions.map(&:price).to_vector(:scale)
    std = @vector.sdp
    within = 4
    @plot_data = @auctions.map do |a|
      next if a.price <= (std * within) || a.price >= ((std * within) * -1)
      [a.time.to_s(:rfc822), a.price]
    end
    @paginate = @item.auctions.not_hidden.order('time DESC').paginate(:page => params[:page], :per_page => 25)
  rescue ActiveRecord::RecordNotFound
    flash[:error] = "Item not found"
    redirect_to auction_index_path
  end
  
end
