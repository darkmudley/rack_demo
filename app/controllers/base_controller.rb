require 'erb'

class BaseController
  attr_reader :request

  def initialize(request)
    @request = request
  end


  def index
    build_response render_template
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


  def render_template(name = params[:action])
    templates_dir = self.class.name.downcase.sub("controller", "")
    template_file = File.join(templates_dir, "#{name}.html.erb")

    file_path = File.expand_path(
      File.join("../../views", template_file),
      __FILE__
    )

    if File.exists?(file_path)
      puts "Rendering template file #{template_file}"
      raw = File.read(file_path)
      ERB.new(raw).result(binding)
    else
      "ERROR: no available template file #{template_file}"
    end
  end
end
