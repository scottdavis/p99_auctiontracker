class AuctionController < ApplicationController
  
  def create
    log_data = params[:upload][:log].read
    log_name = "/tmp/p99_#{Digest::MD5.hexdigest(log_data)}.log"
    @log = Log.create(:ip_address => request.remote_ip, :log => log_name)
    f = File.new(log_name, "w")
    f << log_data
    f.close
    @auction_data = AuctionParser.from_upload(log_data)
    redirect_to root_path unless @log.save
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
  
  def show
    @item = Item.find(params[:id], :include => :auctions)
    @auctions = @item.auctions.paginate(:page => params[:page], :per_page => 25, :order => 'time DESC')
    @underscored = @item.name.gsub(/\s/, '_')
    @graph_file = Rails.root.join("public/images/graph/#{@underscored}.png")
    @graph = Gruff::Line.new
    @graph.theme_keynote
    @graph.title = @item.name
    @graph.data(" ", @item.auctions.map(&:price))
    times = @item.auctions.map {|auc| auc.time.strftime("%a %b %d %I:%M %p")}
    @graph.labels = {}
    @graph.write(@graph_file) if @item.auctions.size > 1
  rescue ActiveRecord::RecordNotFound
    flash[:error] = "Item not found"
    redirect_to auction_index_path
  end
  
end
