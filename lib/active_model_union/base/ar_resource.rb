require 'active_support/concern'

module ActiveModelUnion
  class Base
    module ArResource
      extend ActiveSupport::Concern

      # Returns the active record object
      #
      # @return [ActiveRecord::Base] or not
      def ar_resource
        return unless type && id
        return unless self.class.union_models.include?(type.to_sym)

        klass = type.classify.constantize rescue nil
        return unless klass
        klass.find_by_id(id)
      end
    end
  end
end
