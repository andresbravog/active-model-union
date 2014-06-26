require 'active_support/concern'

module ActiveModelUnion
  class Relation
    module Joins
      extend ActiveSupport::Concern

      # Delegates the function to each one off the union
      # relations with the given args
      #
      # @param args accepts the same args that the active record one
      def joins(*args)
        execute_in_union_relations(union_relations, :joins, *args)
        self
      end

      # Delegates the function to the given
      # relations with the given args
      #
      # @param relations [Array<Symbol>] relations to executed in
      # @param args accepts the same args that the active record one
      def joins_in(relations, *args)
        execute_in_union_relations([*relations], :joins, *args)
        self
      end
    end
  end
end
