app_files = File.expand_path('../app/**/*.rb', __FILE__)
Dir.glob(app_files).each { |file| require(file) }

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
