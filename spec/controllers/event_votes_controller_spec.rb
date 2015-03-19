require 'rails_helper'

RSpec.describe EventVotesController, type: :controller do
  let(:user) { FactoryGirl.create(:user) }
  let(:event) { FactoryGirl.create(:event) }

  let(:params) {
    {
      id: event.id,
      auth_token: user.auth_token,
      user_id: user.id,
    }
  }

  describe '#update' do
    context 'simlple like' do
      before do
        put :update, params.merge(vote: true)
        event.reload
      end

      it { expect(event.likes).to eq(1) }
      it { expect(response).to have_http_status(:ok) }

      it "doesn't like event twice by the same user" do
        put :update, params.merge(vote: true)
        event.reload
        expect(event.likes).to eq(1)
      end
    end

    context 'undo dislike' do
      let!(:vote) { FactoryGirl.create(:vote,
                                       voter: user,
                                       votable: event,
                                       vote_flag: true) }

      before do
        put :update, params.merge(vote: true)
        event.reload
      end

      it { expect(event.likes).to eq(1) }
      it { expect(event.dislikes).to be_zero }
    end

    context 'simple dislike' do
      before do
        put :update, params.merge(vote: false)
        event.reload
      end

      it { expect(event.dislikes).to eq(1) }

      it "doesn't dislike event twice by the same user" do
        put :update, params.merge(vote: false)
        event.reload
        expect(event.dislikes).to eq(1)
      end
    end

    context 'undo like' do
      let!(:vote) { FactoryGirl.create(:vote,
                                       voter: user,
                                       votable: event,
                                       vote_flag: false) }


      before do
        put :update, params.merge(vote: false)
        event.reload
      end

      it { expect(event.likes).to be_zero }
      it { expect(event.dislikes).to eq(1) }
    end
  end

end
