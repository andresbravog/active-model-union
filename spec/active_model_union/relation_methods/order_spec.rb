require 'spec_helper'

describe ActiveModelUnion::Relation do
  describe '#order' do
    let(:params) { Hash[id: :desc] }
    subject { ActiveModelUnion::Relation.new(Resource, Resource.union_models, Resource.union_attributes).order(params) }

    it 'returns a ActiveModelUnion:Relation' do
      expect(subject.class).to eql(ActiveModelUnion::Relation)
    end
    it 'sets union_query_element order with the order sentence' do
      expect(subject.union_query_elements).to include(:order)
      expect(subject.union_query_elements[:order]).to eql(' ORDER BY id DESC')
    end
    it 'multiple calls to order picks the last one' do
      params = {id: :asc}
      expect(subject.order(params).union_query_elements[:order]).to eql(' ORDER BY id ASC')
    end
    it 'allows multiple orders' do
      params = {id: :asc, name: :desc}
      expect(subject.order(params).union_query_elements[:order]).to eql(' ORDER BY id ASC, name DESC')
    end
    it 'allows strign sentences' do
      params = 'id ASC, name DESC'
      expect(subject.order(params).union_query_elements[:order]).to eql(' ORDER BY id ASC, name DESC')
    end
  end
end
