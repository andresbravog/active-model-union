require 'active_support/concern'

module ActiveModelUnion
  module RelationMethods
    module Paginate
      extend ActiveSupport::Concern

      included do
        attr_accessor :page, :per_page
      end

      # Delegates the function to each one off the union
      # relations with the given args
      #
      # @param options [Hash]
      # @option options [Integer] per_page (50) elements per page
      # @option options [Integer] page (1) page number to show
      def paginate(options={})
        populate_pagination_attributes_from_options(options)
        limit(per_page)
        offset((page - 1) * per_page)
        self
      end

      # Number off total pages
      #
      # @return [Integer]
      def total_pages
        (count / per_page.to_f).ceil
      end

      # Current page number
      #
      # @return [Integer]
      def current_page
        page
      end

      # Previous page number if there is
      #
      # @return [Integer]
      def previous_page
        return if page == 0
        page - 1
      end

      # Next page number if there is one
      #
      # @return [Integer]
      def next_page
        return if page == total_pages
        page + 1
      end

      protected

      # Populates pagination attributes from given options or default
      #
      # @param options [Hash]
      # @option options [Integer] per_page (50) elements per page
      # @option options [Integer] page (1) page number to show
      def populate_pagination_attributes_from_options(options={})
        self.page = options[:page] || page || 1
        self.per_page = options[:per_page] || per_page || 50
      end
    end
  end
end
