class BaseController
  attr_reader :request

  def initialize(request)
    @request = request
  end


  def root_path
    build_response 200, render_template(:index, '')
  end


  private

  def build_response(status, body)
    [status, { 'Content-Type' => 'text/html' }, [body]]
  end

  def redirect_to(url)
    [302, { 'Location' => url }, []]
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
