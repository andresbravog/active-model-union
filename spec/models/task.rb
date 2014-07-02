class Task
  ATTRIBUTES = [:name, :id, :due_on]
  attr_accessor *ATTRIBUTES

  class << self
    # some QueryMethods
    def select(*args); return self; end
    def where(*args); return self; end
    def joins(*args); return self; end
    def limit(*args); return self; end
    def offset(*args); return self; end
    def count(*args); return 0; end
    def find(*args); return nil; end

    def table_name
      self.to_s.downcase
    end

    def to_sql
      "SELECT `#{table_name}`.* FORM `#{table_name}` WHERE `#{table_name}`.`id` > 0"
    end
  end


  def attributes
    attr_strings = ATTRIBUTES.map(&:to_s)
    Hash[attr_strings.zip(attr_strings)]
  end
end
