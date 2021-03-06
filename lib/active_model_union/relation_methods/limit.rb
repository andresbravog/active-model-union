require 'active_support/concern'

module ActiveModelUnion
  module RelationMethods
    module Limit
      extend ActiveSupport::Concern

      # Limits the union sentence
      #
      # @param max [Integer] max limit of results to show
      # @param offset [Integer] (optional) offset in the search
      # @return [ActiveModelUnion::Relation]
      def limit(max)
        limit_union_sentence(max)
        self
      end

      protected

      # generagetes the order sql sentence
      # from the union based on ht given args
      #
      # @param max [Integer] max limit of results to show
      # @param offset [Integer] (optional) offset in the search
      # @return [String]
      def limit_union_sentence(max)
        @union_query_elements ||= {}
        @union_query_elements[:limit] = Arel::Nodes::Limit.new(max.to_i)
      end
    end
  end
end
