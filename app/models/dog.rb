require './app/models/base'

class Dog < Base
  attr_accessor :id, :name

  def initialize(*args)
    @id, @name = args
  end
end
