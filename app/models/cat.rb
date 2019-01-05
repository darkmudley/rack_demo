require_relative './base.rb'

class Cat < Base
  attr_accessor :id, :name, :colour

  def initialize(id: nil, name: nil, colour: nil)
    @id = id
    @name = name
		@colour = colour
  end
end
