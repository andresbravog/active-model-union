class Conversation
  ATTRIBUTES = [:name, :id]
  attr_accessor *ATTRIBUTES

  def attributes
    ATTRIBUTES
  end
end
