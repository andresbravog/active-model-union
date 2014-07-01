require 'active_support/concern'

module ActiveModelUnion
  module RelationMethods
    module All
      extend ActiveSupport::Concern

      # Executes the query returning the given model instances
      #
      def all
        results = ActiveRecord::Base.connection.execute(generate_union_query)
        results.map do |values|
          model.new(attributes_hash_for(values))
        end
      end

      # Returns the query to be executed
      #
      # @return [String]
      def to_sql
        generate_union_query
      end

      protected

      # Generates the union query to be executed
      #
      # @return [String]
      def generate_union_query
        query = union_relations.map { |model_name, relation| relation.to_sql }
                               .join("\n UNION \n")
        return query unless union_query_elements.empty?
        query += "\n"
        query += union_query_elements[:order].to_sql if union_query_elements[:order]
        query += union_query_elements[:limit].to_sql if union_query_elements[:limit]
        query += union_query_elements[:offset].to_sql if union_query_elements[:offset]
      end

      # Zips the values with the union attributes in order to
      # get a hash of attr => value
      #
      # @return [Hash]
      def attributes_hash_for(values)
        attributes = union_attributes + [:type]
        zipped = attributes.zip(values)
        Hash[zipped]
      end
    end
  end
end

