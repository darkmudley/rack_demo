require './app/controllers/base_controller'

class CatsController < BaseController
  def index
    build_response 200, "this is Cats#index"
  end


  def show
    build_response 200, "this is Cats#show  id: #{params[:id]}"
  end
end
