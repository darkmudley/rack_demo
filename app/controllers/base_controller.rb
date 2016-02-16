class BaseController
  attr_reader :request

  def initialize(request)
    @request = request
  end

  private

  def build_response(status, body)
    [status, { 'Content-Type' => 'text/html' }, [body]]
  end


  def params
    request.params
  end


  def render_template(name)
    dir_name = self.class.name.downcase.sub("controller", "")
    file_path = File.expand_path("./app/views/#{dir_name}/#{name}.html.erb")
    if File.exists?(file_path)
      File.read(file_path)
    end
  end
end
