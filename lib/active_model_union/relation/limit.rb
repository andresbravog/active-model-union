require 'active_support/concern'

module ActiveModelUnion
  class Relation
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
        @union_query ||= ""
        @union_query += " LIMIT #{max} "
        @union_query += " OFFSET #{offset} " if offset
      end
    end
  end
end
