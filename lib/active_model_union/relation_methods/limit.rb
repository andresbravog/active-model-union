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
      def limit(max, offset=nil)
        limit_union_sentence(max, offset)
        self
      end

      protected

      # generagetes the order sql sentence
      # from the union based on ht given args
      #
      # @param max [Integer] max limit of results to show
      # @param offset [Integer] (optional) offset in the search
      # @return [String]
      def limit_union_sentence(max, offset=nil)
        @union_query_elements ||= {}
        @union_query_elements[:limit] = Arel::Nodes::Limit.new(max.to_i)
        @union_query_elements[:offset] = Arel::Nodes::Offset.new(offset.to_i) if offset
      end
    end
  end
end
