require './app/controllers/base_controller'

class DogsController < BaseController
  def index
    build_response 200, "this is Dogs#index"
  end


  def show
    build_response 200, "this is Dogs#show  id: #{params[:id]}"
  end
end
