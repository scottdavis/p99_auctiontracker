class ItemController < ApplicationController
  
  def destroy
    @item = Item.find(params[:id])
    @item.hide!
    flash[:notice] = "Item deleted"
    redirect_to auction_index_path(:letter => params[:letter])
  end
  
  def show
    expires_in(3.hours)
    @item = Item.find(params[:id])
    @auctions = @item.auctions.not_hidden.paginate(:page => params[:page], :per_page => 25, :order => 'time DESC')
    @underscored = @item.name.gsub(/\s/, '_')
    #@graph_file = Rails.root.join('public', 'images', 'graph', "#{@underscored}.png")
    #@graph = Gruff::Line.new
    #@graph.theme_keynote
    #@graph.title = @item.name
    #@graph.data(" ", @item.auctions.not_hidden.map(&:price))
    #times = @item.auctions.not_hidden.map {|auc| auc.time.strftime("%a %b %d %I:%M %p")}
    #@graph.labels = {}
    #@graph.write(@graph_file) if @item.auctions.not_hidden.size > 1
  rescue ActiveRecord::RecordNotFound
    flash[:error] = "Item not found"
    redirect_to auction_index_path
  end
  
end
