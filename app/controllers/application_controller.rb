class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :init_page_title
  
  
  def init_page_title
    if session[:view].blank?
      session[:view] = 0
    end
    session[:view] += 1
    @page_title = ["Auction Tracker"]
    @glog = Log.order("created_at DESC").first
  end
end
