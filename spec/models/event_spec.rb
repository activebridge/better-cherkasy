require 'rails_helper'

RSpec.describe Event, type: :model do
  subject { FactoryGirl.build(:event) }

  it { should be_valid }

  context 'scopes' do
    let!(:pending_event) { FactoryGirl.create(:event, date: Date.tomorrow) }
    let!(:pending_event2) { FactoryGirl.create(:event, date: Date.tomorrow) }
    let!(:in_progress) { FactoryGirl.create(:event, date: Date.yesterday) }
    let!(:completed) { FactoryGirl.create(:event, date: Date.yesterday, completed: true) }

    context '.pending' do
      subject { Event.pending }
      it { should have(2).item }
    end

    context '.in_progress' do
      subject { Event.in_progress }
      it { should have(1).item }
    end

    context '.completed' do
      subject { Event.completed }
      it { should have(1).item }
    end
  end
end
