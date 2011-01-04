class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :init_page_title
  
  
  def init_page_title
    @page_title = ["Project 1999 Auction Tracker"]
    @glog = Log.order("created_at DESC").first
  end
end
