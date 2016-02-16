class Router
  def initialize(request)
    @request = request
  end

  def path_info
    {
      group: path_components[0],
      id: path_components[1],
      action: path_components[2]
    }
  end

  def path_components
    @comps ||= @request.path.split("/").reject { |s| s.empty? }
  end
end
