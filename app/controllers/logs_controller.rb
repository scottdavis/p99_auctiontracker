class LogsController < ApplicationController
  def index
    @logs = Log.all
    render :json => @logs.to_json(:only => [:created_at, :processed, :public_path], :methods => :public_path)
  end
  
end
