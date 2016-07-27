require_relative './base_controller.rb'

class CatsController < BaseController
  def index
    @title = "This is Cats#index"
    build_response render_template(:index)
  end


  def show
    @title = "This is Cats#show - id: #{params[:id]}"
    build_response render_template(:show)
  end
end
