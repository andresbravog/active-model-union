require 'spec_helper'

describe ActiveModelUnion::Relation do
  let(:relation) { ActiveModelUnion::Relation.new(Resource, Resource.union_models, Resource.union_attributes) }

  describe '#offset' do
    let(:params) { 50 }
    subject { relation.offset(params) }

    it 'returns a ActiveModelUnion:Relation' do
      expect(subject.class).to eql(ActiveModelUnion::Relation)
    end
    it 'sets union_query_element order with the order sentence' do
      expect(subject.union_query_elements).to include(:offset)
      expect(subject.union_query_elements[:offset]).to eql(Arel::Nodes::Offset.new(50))
    end
    it 'multiple calls to offset picks the last one' do
      params = 20
      expect(subject.offset(params).union_query_elements[:offset]).to eql(Arel::Nodes::Offset.new(20))
    end
    it 'not allows strign sentences' do
      params = 'id ASC, name DESC'
      expect(subject.offset(params).union_query_elements[:offset]).to_not eql('id ASC, name DESC')
    end
  end
end
