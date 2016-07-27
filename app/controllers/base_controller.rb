require 'erb'

class BaseController
  attr_reader :request

  def initialize(request)
    @request = request
  end


  def index
    build_response render_template(:index, '')
  end


  private

  def build_response(body, status: 200)
    [status, { "Content-Type" => "text/html" }, [body]]
  end

  def redirect_to(uri)
    [302, { "Location" => uri }, []]
  end


  def params
    request.params
  end


  def render_template(name, dir=nil)
    dir_name = dir || self.class.name.downcase.sub("controller", "")
    file_path = File.expand_path(
      File.join("./app/views", dir_name, "#{name}.html.erb")
    )
    if File.exists?(file_path)
      raw = File.read(file_path)
      ERB.new(raw).result(binding)
    end
  end
end
