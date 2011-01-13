class LogsController < ApplicationController
  
  def index
    @logs = Log.all
    render :json => @logs.to_json(:except=> :ip_address)
  end
  
end
