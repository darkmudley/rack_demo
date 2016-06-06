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


  def new
    @title = "Create e new dog"
    build_response 200, render_template(:new)
  end


  def create
    dog = Dog.new(nil, params['dog']['name'])
    dog.save

    redirect_to "dogs/#{dog.id}"
  end
end
