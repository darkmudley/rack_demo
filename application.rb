require './app/router'
require './app/controllers/dogs_controller'
require './app/controllers/cats_controller'

class Application
  def call(env)
    request = Rack::Request.new(env)

    if request.path =~ /favicon/
      return [404, {}, ["No Favicons here"]]
    end

    serve_request(request)
  end


  def serve_request(request)
    Router.new(request).process!
  end
end
