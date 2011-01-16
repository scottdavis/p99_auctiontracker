class LogsController < ApplicationController
  def index
    #@logs = Log.all
   render :text => 'HA!'
  end
  
end
