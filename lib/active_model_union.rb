require 'active_support'

module ActiveModelUnion
  extend ActiveSupport::Autoload

  autoload :Base

  module BaseMethods
    extend ActiveSupport::Autoload

    autoload :ArResource
    autoload :QueryMethods
    autoload :UntabledModel
  end

  autoload :Relation

  module RelationMethods
    extend ActiveSupport::Autoload

    autoload :All
    autoload :Count
    autoload :Joins
    autoload :Limit
    autoload :Order
    autoload :Paginate
    autoload :Where
    autoload :Offset
  end
end
