class Application
  def call(env)
    request = Rack::Request.new(env)

    if request.path =~ /favicon/
      return build_response 404, "No Favicons here"
    end
    status = 200
    body = "The requested PATH is: <code>#{request.path}</code>"

    build_response 200, body
  end


  def build_response(status, body)
    [status, { 'Content-Type' => 'text/html' }, [body]]
  end
end
