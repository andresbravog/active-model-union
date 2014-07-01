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
        @union_query_elements ||= {}
        @union_query_elements[:order] = " ORDER BY " + order_union_attributes(*args).join(', ')
      end

      # generate a order union attributes array
      #
      # @return [Array<String>]
      def order_union_attributes(*args)
        arguments = preprocess_order_args(args)
        arguments.flat_map do |arg|
          case arg
          when String, Symbol
            arg
          when Hash
            arg.map do |field, order|
              [:asc, :desc].include?(order.to_sym.downcase) ? "#{field.to_s} #{order.to_s.upcase}" : field.to_s
            end
          end
        end
      end

      # Sanitizes the order args to avoid sql injection
      #
      def preprocess_order_args(order_args)
        order_args.flatten!
        validate_order_args(order_args)

        references = order_args.grep(String)
        references.map! { |arg| arg =~ /(\%27)|(\')|(\-\-)|(\%23)|(\#)/ix && $1 }.compact!
        if references.any?
          raise ArgumentError, 'sql injection attemp detected'
        end
        order_args
      end

      VALID_DIRECTIONS = [:asc, :desc, :ASC, :DESC,
                        'asc', 'desc', 'ASC', 'DESC'] # :nodoc:

      # Validate order args
      def validate_order_args(args)
        args.each do |arg|
        next unless arg.is_a?(Hash)
        arg.each do |_key, value|
          raise ArgumentError, "Direction \"#{value}\" is invalid. Valid " \
                               "directions are: #{VALID_DIRECTIONS.inspect}" unless VALID_DIRECTIONS.include?(value)
        end
      end
      end
    end
  end
end
