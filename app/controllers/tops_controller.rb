class TopsController < ApplicationController
  def index
    @current_client_list = CurrentMacs.all
    @named_list = NamedList.all
  end
end