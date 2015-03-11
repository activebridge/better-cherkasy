require 'rails_helper'

RSpec.describe SubscriptionsController, type: :controller do

  describe '#create' do
    let(:user) { FactoryGirl.create(:user) }
    let(:event) { FactoryGirl.create(:event) }

    let(:subscription_params) {
      {
        subscription: {
          event_id: event.id
        }
      }
    }

    before do
      post :create, subscription_params.merge(auth_token: user.auth_token)
    end

    it { should respond_with :created }
    it { expect(json).to have_key('id') }
    it { expect(json).to have_key('user') }
  end

  describe '#destroy' do
    let(:user) { FactoryGirl.create(:user) }
    let(:event) { FactoryGirl.create(:event) }
    let!(:subscription) { FactoryGirl.create(:subscription, user: user, event: event) }

    let(:subscription_params) {
      {
        id: subscription.id
      }
    }

    before do
      delete :destroy, subscription_params.merge(auth_token: user.auth_token)
    end

    it { should respond_with :accepted }
    it { expect { subscription.reload }.to raise_error(ActiveRecord::RecordNotFound) }
  end
end
