require 'active_support/concern'

module ActiveModelUnion
  class Base
    module UntabledModel
      extend ActiveSupport::Concern

      included do
        include ActiveModel::Validations
        include ActiveModel::Conversion
        extend ActiveModel::Naming
      end

      module ClassMethods
        def attr_accessor(*vars)
          @attributes ||= []
          @attributes.concat( vars )
          super
        end

        def attributes
          @attributes
        end

        def inspect
          "#<#{ self.to_s} #{ self.attributes.collect{ |e| ":#{ e }" }.join(', ') }>"
        end
      end

      def initialize(attributes={})
        attributes && attributes.each do |name, value|
          send("#{name}=", value) if respond_to? name.to_sym
        end
      end

      def persisted?
        false
      end
    end
  end
end
