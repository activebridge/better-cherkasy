require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  let(:user) { FactoryGirl.create(:user) }
  let(:event) { FactoryGirl.create(:event) }
  let!(:comment) { FactoryGirl.create(:comment, user: user, commentable: event) }

  describe '#index' do
    let!(:comment2) { FactoryGirl.create(:comment, user: user, commentable: event) }

    before do
      get :index, event_id: event.id, auth_token: user.auth_token
    end

    it { should respond_with :success }
    it { expect(json).to have(2).items }
  end

  describe '#create' do
    let(:params) {
      {
        event_id: event.id,
        auth_token: user.auth_token,
        body: 'hello world'
      }
    }

    before do
      post :create, params
    end


    it { should respond_with :created }
    it { expect(json).to have_key('index') }
    it { expect(json).to have_key('data') }
    it { expect(json['data']).to have_key('id') }
  end

end
