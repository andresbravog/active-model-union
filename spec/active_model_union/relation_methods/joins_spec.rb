require 'spec_helper'

describe ActiveModelUnion::Relation do
  let(:relation) { ActiveModelUnion::Relation.new(Resource, Resource.union_models, Resource.union_attributes) }

  describe '#joins' do
    let(:params) { :comments }
    subject { relation.joins(params) }
    it 'calls each realtion with joins and the given params' do
      expect(Task).to receive(:joins).with(params).and_call_original
      expect(Conversation).to receive(:joins).with(params).and_call_original
      subject
    end
    it 'returns an ActiveModelUnion::Relation' do
      expect(subject.class).to eql(ActiveModelUnion::Relation)
    end
  end

  describe '#joins_in' do
    let(:params) { :comments }
    subject { relation.joins_in(:task, params) }
    it 'calls given realation with joins and the given params' do
      expect(Task).to receive(:joins).with(params).and_call_original
      expect(Conversation).to_not receive(:joins).with(params).and_call_original
      subject
    end
    it 'returns an ActiveModelUnion::Relation' do
      expect(subject.class).to eql(ActiveModelUnion::Relation)
    end
  end
end
