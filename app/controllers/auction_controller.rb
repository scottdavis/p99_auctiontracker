require 'auction_parser'
class AuctionController < ApplicationController
  
  def create
    log_data = params[:upload][:log].read
    log_name = "/tmp/p99_#{Digest::MD5.hexdigest(log_data)}.log"
    @log = Log.create(:ip_address => request.remote_ip, :log => log_name)
    f = File.new(log_name, "w")
    f << log_data
    f.close
    @auction_data = AuctionParser.from_upload(log_data)
    session[:uploaded] = true
    redirect_to root_path unless @log.save
  end
  
  def index
    expires_in(1.minute)
    @search = ''
    unless params.include?(:letter)
      params[:letter] = 'a'
    end
    @letter = params[:letter]
    @popup = render_to_string('layouts/popup', :layout => false).gsub("\n", '').gsub(/("|')/, "\\#{$1}")
    @items = Item.name_starts_with(params[:letter]).order('name ASC').include(:auctions).not_hidden
  end
  
  def destroy
    auction = Auction.find(params[:id])
    expire_page :action => "show", :id => params[:id]
    flash[:notice] = "Auction removed"
    redirect_to :back if auction.hide!
  end
  
  def search
    @search = params[:search][:search]
    @items = Item.search_for(params[:search][:search].downcase).order('name ASC').include(:auctions).not_hidden
    render :action => :index
  end
  
  def show
    redirect_to item_path(params[:id]), :status => 302
  end
  
end
