require './app/router'

class Application
  def call(env)
    request = Rack::Request.new(env)

    if request.path =~ /favicon/
      return build_response 404, "No Favicons here"
    end

    router = Router.new(request)
    body = "The request will be routes to: <code>#{router.controller_name}##{router.action}</code>"

    build_response 200, body
  end


  def build_response(status, body)
    [status, { 'Content-Type' => 'text/html' }, [body]]
  end
end
