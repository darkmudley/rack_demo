class Application
  def call(env)
    request = Rack::Request.new(env)

    status  = 200
    headers = { 'Content-Type' => 'text/html' }
    body    = "The requested PATH is: <code>#{request.path}</code>"
    
    response = Rack::Response.new(body, status, headers)

    response.write "<br>This is getting more structured."

    response.finish
  end
end
