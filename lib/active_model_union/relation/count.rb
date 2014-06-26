require 'active_support/concern'

module ActiveModelUnion
  class Relation
    module Count
      extend ActiveSupport::Concern

      # Delegates the function to each one off the union
      # relations with the given args
      #
      # @param args accepts the same args that the active record one
      def count(*args)
        union_relations.sum do |union_model, relation|
          union_relations[union_model] = relation.send(:count, *args)
        end
      end
    end
  end
end
