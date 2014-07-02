require 'spec_helper'

describe ActiveModelUnion::Relation do
  let(:relation) { ActiveModelUnion::Relation.new(Resource, Resource.union_models, Resource.union_attributes) }

  describe '#all' do
    subject { relation.count }
    it 'calls each realtion with count' do
      expect(Task).to receive(:count).and_call_original
      expect(Conversation).to receive(:count).and_call_original
      subject
    end
    it 'returns the sum of both' do
      expect(subject).to eql(Task.count + Conversation.count)
    end
    it 'returns an integer' do
      expect(subject.class).to eql(Fixnum)
    end
  end
end
