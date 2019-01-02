class Router
  def initialize(request)
    @request = request
		puts @request.path_info
  end

  def route!
    if klass = controller_class
      add_route_info_to_request_params!

      controller = klass.new(@request)
      action = route_info[:action]

      if controller.respond_to?(action)
        puts "\nRouter route! Routing to #{klass}##{action}"
        return controller.public_send(action)
      end
    end

    not_found
  end

  private

  def add_route_info_to_request_params!
    @request.params.merge!(route_info)
  end

  def controller_name
    "#{route_info[:resource].capitalize}Controller"
  end

  def controller_class
    Object.const_get(controller_name)
  rescue NameError
    nil
  end

  def route_info
    @route_info ||= begin
      resource = path_fragments[0] || "base"
      id, action = find_id_and_action(path_fragments[1])
      puts "Router route_info { resource: #{resource}, id: #{id}, action: #{action} }"
      { resource: resource, id: id, action: action }
    end
  end

  def find_id_and_action(fragment)
    case fragment
    when "new"
			puts "Router find_id_and_action new case\n"
      [nil, :new]
    when "remove"
			puts "Router find_id_and_action remove case\n"
      [nil, :remove]
    when "delete"
			puts "Router find_id_and_action delete case\n"
      [nil, :delete]
    when nil
			puts "Router find_id_and_action nil case\n"
      [nil, :index]
		when "index"
			puts "Router find_id_and_action index case\n"
			[nil, :index]
		when "create"
			puts "Router find_id_and_action create case\n"
			[nil, :create]
		when "error"
			puts "Router find_id_and_action error case\n"
			[nil, :error]
    else
      [fragment, :show]
    end
  end

  def path_fragments
		puts "Router path_fragments request.path: #{@request.path}\n"
    @fragments ||= @request.path.split("/").reject { |s| s.empty? }
		p @fragments
  end

  def not_found(msg = "Not Found")
    [404, { "Content-Type" => "text/plain" }, [msg]]
  end
end
