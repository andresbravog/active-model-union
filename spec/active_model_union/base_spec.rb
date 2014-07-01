require 'spec_helper'

describe ActiveModelUnion::Base do
  subject { Resource }

  describe '#union_model' do
    it 'defines the union_models accessor' do
      expect(subject.union_models).to eql([:task, :conversation])
    end
  end

  describe '#union_attribute' do
    it 'defines the union_attributes accessor' do
      expect(subject.union_attributes).to include(:name)
      expect(subject.union_attributes).to include(:due_on)
    end
    it 'adds the id union_attribute' do
      expect(subject.union_attributes).to include(:id)
    end
    it 'sets the attr_accessor for the given methods' do
      expect(subject.new).to respond_to(:name)
      expect(subject.new).to respond_to(:name=)
      expect(subject.new).to respond_to(:due_on)
      expect(subject.new).to respond_to(:due_on=)
    end
  end

  describe '#attr_accessor' do
    subject { Resource.new }
    it 'adds attr_accessor for :id' do
      expect(subject).to respond_to(:id)
      expect(subject).to respond_to(:id=)
    end
    it 'adds attr_accessor for :type' do
      expect(subject).to respond_to(:type)
      expect(subject).to respond_to(:type=)
    end
  end
end
