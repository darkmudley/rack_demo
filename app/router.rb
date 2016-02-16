class Router
  def initialize(request)
    @request = request
  end


  def controller_name
    "#{path_info[:group].capitalize}Controller"
  end


  def controller
    Object.const_get(controller_name)
  end


  def action
    if path_info[:action]
      path_info[:action].to_sym
    else
      if path_info[:id]
        :show
      else
        :index
      end
    end
  end


  def path_info
    @path_info ||= {
      group: path_components[0],
      id: path_components[1],
      action: path_components[2]
    }
  end


  def path_components
    @comps ||= @request.path.split("/").reject { |s| s.empty? }
  end
end
