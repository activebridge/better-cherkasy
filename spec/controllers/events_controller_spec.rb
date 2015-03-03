require 'rails_helper'

RSpec.describe EventsController, type: :controller do
  describe '#index' do
    context 'default order' do
      let!(:bad_event) { FactoryGirl.create(:event, rating: -15) }
      let!(:good_event) { FactoryGirl.create(:event, rating: 255) }
      let!(:very_bad_event) { FactoryGirl.create(:event, rating: -125) }

      before do
        get :index
      end

      it { expect(json).to have(3).items }
      it { expect(json[0]['id']).to eq(good_event.id) }
      it { expect(json[1]['id']).to eq(bad_event.id) }
      it { expect(json[2]['id']).to eq(very_bad_event.id) }
    end
  end
end
