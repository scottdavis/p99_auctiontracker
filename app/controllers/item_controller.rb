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
    mean = @vector.mean
    within = (2 * std)
    max = mean + within
    min = mean - within
    @plot_data = @auctions.map do |a|
      if a.price.to_f > max.to_f
       # [a.time.to_s(:rfc822), max]
      elsif a.price.to_f < min.to_f
       # [a.time.to_s(:rfc822), min]
      else
        [a.time.to_s(:rfc822), a.price]
      end
    end
    @paginate = @item.auctions.not_hidden.order('time DESC').paginate(:page => params[:page], :per_page => 25)
  rescue ActiveRecord::RecordNotFound
    flash[:error] = "Item not found"
    redirect_to auction_index_path
  end
  
end
