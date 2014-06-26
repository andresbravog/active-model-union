require 'active_support/concern'

module ActiveModelUnion
  module RelationMethods
    module Where
      extend ActiveSupport::Concern

      # Delegates the function to each one off the union
      # relations with the given args
      #
      # @param args accepts the same args that the active record one
      def where(*args)
        execute_in_union_relations(union_relations, :where, *args)
        self
      end

      # Delegates the function to the given
      # relations with the given args
      #
      # @param relations [Array<Symbol>] relations to executed in
      # @param args accepts the same args that the active record one
      def where_in(relations, *args)
        execute_in_union_relations([*relations], :where, *args)
        self
      end
    end
  end
end
