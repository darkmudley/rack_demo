require_relative './base_controller.rb'

class DogsController < BaseController
  def index
    @title = "So many dogs"
    @dogs = Dog.all
    build_response render_template
  end


  def show
    @dog = Dog.find(params[:id])
    @title = "#{@dog.name}'s page"
    build_response render_template
  end


  def new
    @title = "More dogs please"
    build_response render_template
  end


  def create
    dog = Dog.new(name: params['dog']['name'])
    dog.save
    redirect_to "dogs/#{dog.id}"
  end
end
