class Task
  ATTRIBUTES = [:name, :id, :due_on]
  attr_accessor *ATTRIBUTES

  def attributes
    ATTRIBUTES
  end
end
