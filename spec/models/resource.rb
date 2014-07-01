class Resource < ActiveModelUnion::Base
  union_model :task, :conversation

  union_attribute :name, :due_on
end
