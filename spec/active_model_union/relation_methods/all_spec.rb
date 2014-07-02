require 'spec_helper'

describe ActiveModelUnion::Relation do
  let(:relation) { ActiveModelUnion::Relation.new(Resource, Resource.union_models, Resource.union_attributes) }

  describe '#all' do
    subject { relation.all }
    let(:connection) { double(:connection, execute: results )}
    let(:active_record_base) do
      unless defined? ActiveRecord::Base
        module ActiveRecord; class Base; end; end
      end
      ActiveRecord::Base
    end
    let(:results) do
      [['1', 'task_name', '2009-11-15 18:04:08', 'task'],
       ['2', 'conversation_name', nil, 'conversation']]
    end
    before do
      allow(active_record_base).to receive(:connection).and_return(connection)
    end
    it 'executes the query in the connection' do
      expect(connection).to receive(:execute).with(relation.to_sql).and_return(results)
      subject
    end
    it 'creates the model objects for each result' do
      expect(subject.map(&:class)).to eql([Resource, Resource])
      expect(subject.map(&:id)).to eql(['1', '2'])
      expect(subject.map(&:name)).to eql(['task_name', 'conversation_name'])
    end
  end

  describe '#to_sql' do
    let(:limit_node) { double(:limit_node, to_sql: ' LIMIT 12')}
    let(:offset_node) { double(:limit_node, to_sql: ' OFFSET 12')}
    subject { relation.to_sql }
    it 'returns a Sring' do
      expect(subject.class).to eql(String)
    end
    it 'calls each realtion with to_sql' do
      expect(Task).to receive(:to_sql)
      expect(Conversation).to receive(:to_sql)
      subject
    end
    it 'joins the relations with UNION sentence' do
      expect(subject).to include('UNION')
    end
    it 'Adds order sentence if present' do
      allow(relation).to receive(:union_query_elements).and_return(order: ' ORDER BY id ASC')
      expect(subject).to include(' ORDER BY id ASC')
    end
    it 'Adds limit sentence if present' do
      allow(relation).to receive(:union_query_elements).and_return(limit: limit_node)
      expect(subject).to include(' LIMIT 12')
    end
    it 'Adds offset sentence if present' do
      allow(relation).to receive(:union_query_elements).and_return(offset: offset_node)
      expect(subject).to include(' OFFSET 12')
    end
  end
end
