require 'spec_helper'

describe ActiveModelUnion::Relation do
  let(:relation) { ActiveModelUnion::Relation.new(Resource, Resource.union_models, Resource.union_attributes) }

  describe '#limit' do
    let(:params) { 5 }
    subject { relation.limit(params) }

    it 'returns a ActiveModelUnion:Relation' do
      expect(subject.class).to eql(ActiveModelUnion::Relation)
    end
    it 'sets union_query_element order with the order sentence' do
      expect(subject.union_query_elements).to include(:limit)
      expect(subject.union_query_elements[:limit]).to eql(Arel::Nodes::Limit.new(5))
    end
    it 'multiple calls to limit picks the last one' do
      params = 2
      expect(subject.limit(params).union_query_elements[:limit]).to eql(Arel::Nodes::Limit.new(2))
    end
    it 'not allows strign sentences' do
      params = 'id ASC, name DESC'
      expect(subject.limit(params).union_query_elements[:limit]).to_not eql('id ASC, name DESC')
    end
  end
end
