require 'active_support/concern'

module ActiveModelUnion
  class Relation
    module All
      extend ActiveSupport::Concern

      # Executes the query returning the given model instances
      #
      def all
        Rails.logger.debug(generate_union_query)
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
        return query unless union_query
        query += "\n" + union_query
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

