require './app/router'

class Application
  def call(env)
    request = Rack::Request.new(env)

    if request.path =~ /favicon/
      return build_response 404, "No Favicons here"
    end

    router = Router.new(request)
    body = "You're requesting: <code>#{router.path_info}</code>"

    build_response 200, body
  end


  def build_response(status, body)
    [status, { 'Content-Type' => 'text/html' }, [body]]
  end
end
