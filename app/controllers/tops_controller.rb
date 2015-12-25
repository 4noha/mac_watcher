class TopsController < ApplicationController
  def index
    @current_client_list = CurrentMacs.all
  end
end