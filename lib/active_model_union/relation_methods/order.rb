require 'active_support/concern'

module ActiveModelUnion
  module RelationMethods
    module Order
      extend ActiveSupport::Concern

      # Orders the union sentence
      # Accepts the same args that the activerecord one
      def order(*args)
        order_union_sentence(*args)
        self
      end

      protected

      # generagetes the order sql sentence
      # forn the union based on ht given args
      #
      # @return [String]
      def order_union_sentence(*args)
        @union_query ||= ""
        @union_query += " ORDER BY " + order_union_attributes(*args).join(',')
      end

      # generate a order union attributes array
      #
      # @return [Array<String>]
      def order_union_attributes(*args)
        args.flat_map do |arg|
          case arg
          when String, Symbol
            arg
          when Hash
            arg.map do |field, order|
              [:asc, :desc].include?(order) ? "#{field.to_s} #{order.to_s}" : field.to_s
            end
          end
        end
      end
    end
  end
end
