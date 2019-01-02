require 'yaml/store'

class Base
  DB_FILE = File.expand_path("../../../db.yml", __FILE__)

  module ClassMethods

    # Find a record by ID
    #
    def find(id)
      db.transaction(true) do
        db[derive_db_id(self.name, id)]
      end
    end

    # Returns all records for this model
    #
    def all
      db.transaction(true) do
        ids = extract_model_ids(db)
        ids.map { |key| db[key] }
      end
    end

    # Store an instance in the DB
    #
    def save(object)
		  puts "Save: Object ID is #{object.id}\n"
      db_id = derive_db_id(object.class.name, object.id)
      db.transaction do
        db[db_id] = object
      end
    end

    # Delete an instance from the DB
    #
    def remove(object)
			puts "Model Remove Object ID is #{object.id}\n"
      db_id = derive_db_id(object.class.name, object.id)
			puts "Found db_id: #{db_id}\n"
      db.transaction do
				db.delete(db_id)
      end
    end

    # Scoped by class, to auto-increment the IDs
    #
    def next_available_id
      last_id = all_ids.map do |key|
        key.sub("#{self.name}_", "").to_i
      end.max.to_i

      last_id + 1
    end

    private

    # Access to the PStore binary file
    #
    def db
      @db ||= YAML::Store.new(DB_FILE)
    end

    # Scoped by class, so that different model classes
    # can have the same numerical IDs
    #
    def derive_db_id(model_name, obj_id)
      "#{model_name}_#{obj_id}"
    end

    # All the IDs for this model
    #
    def all_ids
      db.transaction(true) do |db|
        extract_model_ids(db)
      end
    end

    # Get all the PStore root keys (the DB IDs)
    # scoped for the current class
    #
    def extract_model_ids(store)
      store.roots.select do |key|
        key.start_with?(self.name)
      end
    end
  end
  extend ClassMethods

	def remove
		puts "Model Remove: Cat ID is #{self.id}\n"
		self.class.remove(self)
	end

  def save
    ensure_presence_of_id
		puts "Save: Cat ID is #{self.id}\n"
    self.class.save(self)
  end

  private

  def ensure_presence_of_id
    self.id ||= self.class.next_available_id
  end
end
