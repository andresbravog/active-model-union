module ActiveModelUnion
  class Base
    include ActiveModelUnion::Base::UntabledModel
    include ActiveModelUnion::Base::QueryMethods
    include ActiveModelUnion::Base::ArResource

    attr_accessor :type, :id

    # Class to set union models
    def self.union_model(*args)
      @union_models ||= []
      @union_models += args
    end

    # Class to set union attributes
    def self.union_attribute(*args)
      @union_attributes ||= [:id]
      @union_attributes += args
      self.attr_accessor *args
    end

    protected

    def self.union_models
      @union_models ||= []
    end

    def self.union_attributes
      @union_attributes ||= []
    end
  end
end
