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

  describe '#create' do
    let(:user) { FactoryGirl.create(:user) }
    let(:event_params) {
      {
        event: {
          headline: 'super duper event',
          description: 'super duper duper event',
          tag_list: 'active, bridge'
        }
      }
    }

    context 'unauthorised' do
      before do
        post :create, event_params
      end

      it { expect(response).to have_http_status(:unauthorized) }
    end

    context 'success' do
      before do
        post :create, event_params.merge(auth_token: user.auth_token)
      end

      context 'general' do
        it { expect(response).to be_success }
        it { expect(json['headline']).to eq('super duper event') }
        it { expect(json['description']).to be }
        it { expect(json['id']).to be }
        it { expect(json['rating']).to eq(0) }
        it { expect(json['creator']).to be }
      end

      context 'tags' do
        it { expect(json['tags']).to_not be_blank }
        it { expect(json['tags']).to have(2).items }
      end
    end
  end
end
