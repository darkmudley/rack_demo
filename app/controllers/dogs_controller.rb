require './app/controllers/base_controller'

class DogsController < BaseController
  def index
    @title = "This is Dogs#index"
    build_response 200, render_template(:index)
  end


  def show
    @title = "This is Dogs#show - id: #{params[:id]}"
    build_response 200, render_template(:show)
  end
end
