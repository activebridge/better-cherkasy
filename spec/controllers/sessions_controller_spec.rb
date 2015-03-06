require 'rails_helper'

RSpec.describe SessionsController, :type => :controller do

  describe '#show' do
    context 'with valid user' do
      let(:user) { FactoryGirl.create(:user) }

      before do
        get :show, id: user.auth_token
      end

      it { expect(json['user']).to be }
      it { expect(response).to be_success }
    end

    context 'with invalid user' do
      before do
        get :show, id: 'XXX'
      end

      it { expect(response).to have_http_status(:unauthorized) }
    end
  end

end
