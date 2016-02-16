require './app/router'
require './app/controllers/dogs_controller'

class Application
  def call(env)
    request = Rack::Request.new(env)

    if request.path =~ /favicon/
      return build_response 404, "No Favicons here"
    end

    serve_request(request)
  end


  def serve_request(request)
    router = Router.new(request)
    request.params.merge!(router.path_info)
    router.controller.new(request).send(router.action)
  end

end
