class Application
  def call(env)
    path = env["REQUEST_PATH"]

    [
      200,
      { 'Content-Type' => 'text/html' },
      ["The requested PATH is: <code>#{path}</code>"]
    ]
  end
end
