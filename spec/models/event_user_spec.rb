require 'rails_helper'

RSpec.describe EventUser, :type => :model do
  context '.liked' do
    let!(:eu1) { FactoryGirl.create(:event_user, liked: true) }
    let!(:eu2) { FactoryGirl.create(:event_user, liked: false) }
    let!(:eu3) { FactoryGirl.create(:event_user, liked: true) }

    it { expect(EventUser.liked.count).to eq 2 }
    it { expect(EventUser.disliked.count).to eq 1 }
  end
end
