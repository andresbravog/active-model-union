require 'active_support/concern'

module ActiveModelUnion
  class Relation
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
      # @option options [Integer] page (0) page number to show
      def paginate(options={})
        populate_pagination_attributes_from_options(options)
        limit(per_page, page * per_page)
        self
      end

      protected

      # Populates pagination attributes from given options or default
      #
      # @param options [Hash]
      # @option options [Integer] per_page (50) elements per page
      # @option options [Integer] page (0) page number to show
      def populate_pagination_attributes_from_options(options={})
        self.page = options[:page] || page || 0
        self.per_page = options[:per_page] || per_page || 50
      end
    end
  end
end
