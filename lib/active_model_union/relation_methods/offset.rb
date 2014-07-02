require 'active_support/concern'

module ActiveModelUnion
  module RelationMethods
    module Offset
      extend ActiveSupport::Concern

      # Offsets the union sentence
      #
      # @param value [Integer] offset of results to show
      # @param offset [Integer] (optional) offset in the search
      # @return [ActiveModelUnion::Relation]
      def offset(value)
        offset_union_sentence(value)
        self
      end

      protected

      # generagetes the order sql sentence
      # from the union based on ht given args
      #
      # @param value [Integer] value offset of results to show
      # @param offset [Integer] (optional) offset in the search
      # @return [String]
      def offset_union_sentence(value)
        @union_query_elements ||= {}
        @union_query_elements[:offset] = Arel::Nodes::Offset.new(value.to_i)
      end
    end
  end
end
