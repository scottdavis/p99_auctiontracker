require 'auction_parser'
class AuctionController < ApplicationController
  
  def create
    folder = Rails.root.join('public', 'system', 'logs')
    FileUtils::mkdir_p(folder)
    name = Digest::MD5.hexdigest("#{Time.now}-#{rand(100)}")
    log_name = File.join(folder, "p99_#{name}.log")
    @log = Log.create(:ip_address => request.remote_ip, :log => log_name)
    FileUtils.mv(params[:upload][:log].tempfile.path, log_name)
    Stalker.enqueue('log.process', {:log => log_name, :id => @log.id}, {:ttr => 1200}) unless Rails.env == 'test'
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
    @items = Item.name_starts_with(params[:letter]).order('name ASC').not_hidden
    prepair_items
  end
  
  def destroy
    auction = Auction.find(params[:id])
    expire_page :action => "show", :id => params[:id]
    flash[:notice] = "Auction removed"
    redirect_to :back if auction.hide!
  end
  
  def search
    @search = params[:search][:search]
    @items = Item.search_for(params[:search][:search].downcase).order('name ASC').not_hidden
    prepair_items
    render :action => :index
  end
  
  def show
    redirect_to item_path(params[:id]), :status => 302
  end
  
  
  private
  
  def prepair_items
    @auctions = {}
    @items.each do |item|
      auctions = item.auctions.where(:hidden => false).select('price').map(&:price).to_vector(:scale)
      next if auctions.size < 10
      @auctions[item.name] = auctions
    end
  end
  
end
