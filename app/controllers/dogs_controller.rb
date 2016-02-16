class DogsController

  attr_reader :request

  def initialize(request)
    @request = request
  end


  def index
    build_response 200, "this is Dogs#index"
  end


  def show
    build_response 200, "this is Dogs#show  id: #{params[:id]}"
  end


  private


  def build_response(status, body)
    [status, { 'Content-Type' => 'text/html' }, [body]]
  end


  def params
    request.params
  end
end
