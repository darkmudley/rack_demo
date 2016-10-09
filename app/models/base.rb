require 'pstore'

class Base
  module ClassMethods
    def find(id)
      db.transaction(true) do
        db[db_id(id)]
      end
    end

    def all
      db.transaction(true) do
        db.roots
          .select { |key| key.start_with?(self.name) }
          .map { |key| db[key] }
      end
    end

    def db
      @db ||= PStore.new("db.pstore")
    end

    def db_id(base)
      "#{self.name}_#{base}"
    end

    def all_ids
      db.transaction(true) { |db| db.roots }
    end

    def next_available_id
      all_ids.map do |key|
        key.sub(/[A-Za-z]+_/, '').to_i
      end.max + 1
    end
  end
  extend ClassMethods


  def save
    ensure_id
    self.class.db.transaction do |db|
      db[db_id] = self
    end
  end


  def db_id
    self.class.db_id(id)
  end


  def ensure_id
    self.id ||= self.class.next_available_id
  end
end
