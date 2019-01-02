require_relative './base_controller.rb'

class CatsController < BaseController
  def index
    @title = "So many cats"
    @cats = Cat.all
    build_response render_template
  end

  def show
    @cat = Cat.find(params[:id])
    @title = "#{@cat.name}'s page"
    build_response render_template
  end

  def new
    @title = "More cats please"
    build_response render_template
  end

  def create
    cat = Cat.new(name: params['cat']['name'])
    puts "Controller Create #{cat.name}"
    cat.save
    redirect_to "/cats"
  end

  def delete
    puts "Controller entering delete page\n"
    @title = "Enter ID of cat to delete"
    build_response render_template
  end

  def remove
		puts "Remove cat ID: #{params['cat']['id']}\n"
    cat = Cat.find(params['cat']['id'])
		p cat
		if cat == nil then
		  error("Cat ID #{params['cat']['id']} not found")
    else
      puts "Controller Remove #{cat.id}"
      cat.remove
      redirect_to "/cats"
    end
  end

  def save
    cat.id.save
    redirect_to "/cats"
  end

  def error(message)
		@title = "Error!"
		@message = message
    build_response render_template(:error)
  end
end
