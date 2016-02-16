require './app/controllers/base_controller'
require './app/models/dog'

class DogsController < BaseController
  def index
    @title = "This is Dogs#index"
    @dogs = Dog.all
    build_response 200, render_template(:index)
  end


  def show
    @title = "This is Dogs#show - id: #{params[:id]}"
    @dog = Dog.find(params[:id])
    build_response 200, render_template(:show)
  end
end
