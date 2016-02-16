require './app/controllers/base_controller'

class CatsController < BaseController
  def index
    build_response 200, render_template(:index)
  end


  def show
    build_response 200, render_template(:show)
  end
end
