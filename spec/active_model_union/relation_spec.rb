require 'spec_helper'

describe ActiveModelUnion::Relation do
  describe '#new' do
    subject { ActiveModelUnion::Relation.new(Resource, Resource.union_models, Resource.union_attributes) }

    it 'sets model accessor to the given model' do
      expect(subject.model).to eql(Resource)
    end
    it 'sets union_models accessor for teh given union_models' do
      expect(subject.union_models).to eql([:task, :conversation])
    end
    it 'sets union_attributes accessor for teh given union_attributes' do
      expect(subject.union_attributes).to eql([:id, :name, :due_on])
    end
    it 'sets union_relations to the models' do
      expect(subject.union_relations).to include(:task)
      expect(subject.union_relations[:task]).to eql(Task)
      expect(subject.union_relations).to include(:conversation)
      expect(subject.union_relations[:conversation]).to eql(Conversation)
    end
    it 'sets applies the select filter to the union_realtions' do
      expect(Task).to receive(:select).with("`task`.`id` as 'id', `task`.`name` as 'name', `task`.`due_on` as 'due_on', 'task' as 'type'")
      subject
    end
    it 'fills not existing relation attibutes with null in the select filter' do
      expect(Conversation).to receive(:select).with("`conversation`.`id` as 'id', `conversation`.`name` as 'name',  null as 'due_on', 'conversation' as 'type'")
      subject
    end
  end
end
