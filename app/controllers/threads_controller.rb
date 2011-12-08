class ThreadsController < ApplicationController
  before_filter :authenticate_user!
  
  def index
    @threads = current_user.messages.roots
    
    respond_to do |format|
      format.html 
      format.json { render json: @threads }
    end
  end
  
  def show
    @messages = current_user.messages.find(params[:id]).subtree

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @messages }
    end
  end


end
