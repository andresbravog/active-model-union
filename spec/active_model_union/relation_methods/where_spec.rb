require 'spec_helper'

describe ActiveModelUnion::Relation do
  let(:relation) { ActiveModelUnion::Relation.new(Resource, Resource.union_models, Resource.union_attributes) }

  describe '#where' do
    let(:params) { { id: [1,2,3] }  }
    subject { relation.where(params) }
    it 'calls each realtion with where and the given params' do
      expect(Task).to receive(:where).with(params).and_call_original
      expect(Conversation).to receive(:where).with(params).and_call_original
      subject
    end
    it 'returns an ActiveModelUnion::Relation' do
      expect(subject.class).to eql(ActiveModelUnion::Relation)
    end
  end

  describe '#where_in' do
    let(:params) { { id: [1,2,3] }  }
    subject { relation.where_in(:task, params) }
    it 'calls given realation with where and the given params' do
      expect(Task).to receive(:where).with(params).and_call_original
      expect(Conversation).to_not receive(:where).with(params).and_call_original
      subject
    end
    it 'returns an ActiveModelUnion::Relation' do
      expect(subject.class).to eql(ActiveModelUnion::Relation)
    end
  end
end
