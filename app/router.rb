class Router
  def initialize(request)
    @request = request
  end


  def process!
    if klass = controller
      @request.params.merge!(path_info)

      ctrl = klass.new(@request)
      method = action

      if ctrl.respond_to?(method)
        puts "\nRouting to #{controller}##{method}"
        return ctrl.public_send(method)
      end
    elsif @request.path == "/"
      return root_path
    end

    not_found
  end


  def controller_name
    "#{path_info[:group].capitalize}Controller"
  end


  def controller
    Object.const_get(controller_name)
  rescue NameError
    nil
  end


  def action
    if path_info[:action]
      path_info[:action].to_sym
    else
      if path_info[:id]
        :show
      else
        @request.get? ? :index : :create
      end
    end
  end


  def path_info
    @path_info ||= begin
      info = {
        group: path_components[0],
        id: path_components[1],
        action: path_components[2]
      }

      if info[:id] == 'new'
        info[:action] = info.delete(:id)
      end
      info
    end
  end


  def path_components
    @comps ||= @request.path.split("/").reject { |s| s.empty? }
  end


  def not_found(msg = "Not Found")
    [404, {}, [msg]]
  end


  def root_path
    BaseController.new(@request).root_path
  end
end
