class TopsController < ApplicationController
  def index
    @current_client_list = CurrentMacs.all
    @named_list = NamedList.all
    @client = NamedList.new
  end
  
  def create
    NamedList.create do |client|
      client.name = params[:named_list][:name]
      client.ip_address = params[:named_list][:ip_address]
      client.mac_address = params[:named_list][:mac_address]
    end
    redirect_to :tops
  end
end