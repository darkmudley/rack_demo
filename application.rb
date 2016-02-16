class Application
  def call(env)
    request = Rack::Request.new(env)

    status = 200
    body = "The requested PATH is: <code>#{request.path}</code>"

    build_response 200, body
  end


  def build_response(status, body)
    [status, { 'Content-Type' => 'text/html' }, [body]]
  end
end
