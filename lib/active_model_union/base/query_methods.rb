require 'active_support/concern'

module ActiveModelUnion
  class Base
    module QueryMethods
      extend ActiveSupport::Concern

      module ClassMethods

        # Executes the given action into an activemodel union relation
        #
        # @return [ActiveModelUnion::Relation]
        def execute_in_union_relation(action, *args)
         relation =  ActiveModelUnion::Relation.new(self, @union_models, @union_attributes)
         relation.send(action, *args)
        end
        protected :execute_in_union_relation

        [:where, :joins, :count].each do |relation_method_name|
          # Delegates the action to the union relation object
          # executing the given action in each union model
          #
          # @return [ActiveModelUnion::Relation]
          define_method(relation_method_name) do |*args|
            execute_in_union_relation(relation_method_name, *args)
          end
        end

        [:where, :joins].each do |relation_method_name|
          relation_method_in_name = "#{relation_method_name}_in"

          # Delegates the action to the union relation object
          # executing the given action in the given union models
          #
          # @return [ActiveModelUnion::Relation]
          define_method(relation_method_in_name) do |relations, *args|
            execute_in_union_relation(relation_method_in_name, [*relations], *args)
          end
        end
      end
    end
  end
end
