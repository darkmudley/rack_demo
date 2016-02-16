require 'pstore'

class Dog
  class << self
    def find(id)
      db.transaction(true) do
        db[db_id(id)]
      end
    end

    def all
      db.transaction(true) do
        db.roots.map { |key| db[key] }
      end
    end

    def db
      @db ||= PStore.new("db.pstore")
    end

    def db_id(base)
      "#{self.name}_#{base}"
    end
  end


  attr_accessor :id, :name


  def initialize(*args)
    @id, @name = args
  end


  def save
    self.class.db.transaction do |db|
      db[db_id] = self
    end
  end


  def db_id
    self.class.db_id(id)
  end
end
