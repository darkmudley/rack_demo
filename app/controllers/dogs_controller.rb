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
    puts "Controller Create #{dog.name}"
    dog.save
    redirect_to "/dogs/#{dog.id}"
  end

  def delete
    puts "Controller entering delete page\n"
    @title = "Enter ID of dog to delete"
    build_response render_template
  end

  def remove
    @dog = Dog.find(params['dog']['id'])
    puts "Controller Remove #{@dog.id}"
    @dog.remove
    redirect_to "/dogs"
  end

  def save
    dog.id.save
    redirect_to "/dogs"
  end

end
