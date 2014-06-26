module ActiveModelUnion
  class Relation
    include ActiveModelUnion::Relation::Where
    include ActiveModelUnion::Relation::Order
    include ActiveModelUnion::Relation::All
    include ActiveModelUnion::Relation::Joins
    include ActiveModelUnion::Relation::Count
    include ActiveModelUnion::Relation::Limit
    include ActiveModelUnion::Relation::Paginate

    attr_accessor :union_models, :union_relations, :union_attributes,  :union_query, :model

    # Constructor
    #
    # @param model [ActiveModelUnion::Base] class base
    # @param union_models [Array<Symbols>] model names to use in the union
    # @param union_attributes [Array<Symbols>] attribute names to be selected in the union query
    # @return [ActiveModelUnion::Relation]
    def initialize(model, union_models=[], union_attributes=[])
      @model = model
      @union_models = union_models
      @union_attributes = union_attributes
      initialize_union_relations(union_relations)
      initialize_union_attributes(union_attributes)
    end

    protected

    # Executes the given action in the union relations stored
    # with the given args
    #
    # @param relations [Array<Symbol>] relations to executed in
    # @param relations [Symbol] action to be executed
    # @param args [] args to use in the action
    def execute_in_union_relations(relations, action, *args)
      selected_union_relations = union_relations.select { |key, value| relations.include? key }
      selected_union_relations.each do |union_model, relation|
        union_relations[union_model] = relation.send(action, *args)
      end
    end

    # Initilalizes the union relations based on the given union models
    #
    def initialize_union_relations(union_relations)
      @union_relations ||= {}
      union_models.each do |union_model|
        model = union_model.to_s.camelcase.constantize
        @union_relations[union_model] = model
      end
    end

    # Adds the needed select filters to the union relations
    # based on the given union atrributes
    #
    def initialize_union_attributes(union_attributes)
      union_relations.each do |union_model, relation|
        model_attributes = relation.new.attributes.keys
        select_sentence_for_model =
          union_attributes.map do |attribute_name|
            if model_attributes.include? attribute_name.to_s
              "#{relation.table_name}.#{attribute_name.to_s}"
            else
              ' null'
            end
          end
        select_sentence_for_model << "\'#{union_model.to_s}\' as \'type\'"
        #select_sentence_for_model << "#{relation.table_name}.id as \'id\'"
        union_relations[union_model] = relation.select(select_sentence_for_model.join(','))
      end
    end
  end
end
