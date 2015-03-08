require 'rails_helper'

RSpec.describe UsersController, :type => :controller do

  describe '#create' do
    context 'with valid params' do
      let(:user_params) {
        {
          name: 'Eugene',
          avatar_url: 'http://super.logo',
          provider: 'facebook',
          providerid: 'QWERTY'
        }
      }

      before do
        post :create, user_params
      end

      it { expect(json['auth_token']).to be }
      it { expect(json['status']).to eq('ok') }
      it { expect(response).to be_success }
    end

    context 'with invalid params' do
      let(:user_params) {
        {
          name: ''
        }
      }

      before do
        post :create, user_params
      end

      it { expect(response).to have_http_status(:unprocessable_entity) }
      it { expect(json['status']).to eq('fail') }
    end
  end

end
