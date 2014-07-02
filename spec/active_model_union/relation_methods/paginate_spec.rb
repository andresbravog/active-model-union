require 'spec_helper'

describe ActiveModelUnion::Relation do
  let(:relation) { ActiveModelUnion::Relation.new(Resource, Resource.union_models, Resource.union_attributes) }

  describe '#paginate' do
    let(:params) { { page: 1, per_page: 20 }  }
    subject { relation.paginate(params) }
    it 'calls limit with the given per_page param' do
      expect(relation).to receive(:limit).with(20).and_call_original
      subject
    end
    it 'calls offset with the needed one' do
      expect(relation).to receive(:offset).with(0).and_call_original
      subject
    end
    it 'returns an ActiveModelUnion::Relation' do
      expect(subject.class).to eql(ActiveModelUnion::Relation)
    end
    it 'keeps the given page and per_page as params in the returned relation' do
      expect(subject.page).to eql(1)
      expect(subject.per_page).to eql(20)
    end
  end

  describe '#total_pages' do
    let(:params) { { page: 1, per_page: 20 }  }
    subject { relation.paginate(params).total_pages }
  end

  describe '#current_page' do
    let(:params) { { page: 1, per_page: 20 }  }
    subject { relation.paginate(params).current_page }
    it { eql(1) }
  end

  describe '#previous_page' do
    let(:params) { { page: 1, per_page: 20 }  }
    subject { relation.paginate(params).current_page }
    it { eql(nil) }
  end

  describe '#next_page' do
    let(:params) { { page: 1, per_page: 20 }  }
    subject { relation.paginate(params).current_page }
    it { eql(2) }
  end
end
