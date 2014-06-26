require 'active_support'

module ActiveModelUnion
  extend ActiveSupport::Autoload

  autoload :Base
  autoload 'Base::ArResource'
  autoload 'Base::QueryMethods'
  autoload 'Base::UntabledModel'

  autoload :Relation
  autoload 'Relation::All'
  autoload 'Relation::Count'
  autoload 'Relation::Joins'
  autoload 'Relation::Limit'
  autoload 'Relation::Order'
  autoload 'Relation::Paginate'
  autoload 'Relation::Where'
end
