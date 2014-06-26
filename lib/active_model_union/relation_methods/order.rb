require 'active_support/concern'

module ActiveModelUnion
  class RelationMethods
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
        order_union_attrs = []
        args.each do |arg|
          case arg
          when String, Symbol
            sentence = arg.to_s
            order_union_attrs << arg
          when Hash
            arg.each do |field, order|
              order_union_attrs <<
              case order
              when :asc, :desc
                "#{field.to_s} #{order.to_s}"
              else
                field.to_s
              end
            end
          end
        end
        order_union_attrs
      end
    end
  end
end