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
    router = Router.new(request)
    request.params.merge!(router.path_info)

    if (klass = router.controller)
      ctrl = klass.new(request)
      method = router.action

      if ctrl.respond_to?(method)
        return ctrl.public_send(method)
      end
    end
    
    [404, {}, ["Not Found"]]
  end

end
