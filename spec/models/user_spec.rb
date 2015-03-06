require 'rails_helper'

RSpec.describe User, :type => :model do
  subject { FactoryGirl.build(:user) }

  it { should be_valid }

  context '#authenticate!' do
    subject { FactoryGirl.create(:user) }
    before do
      subject.authenticate!
    end

    its(:auth_token) { should_not be_blank }

    context 'generates different token on call' do
      let!(:token1) { subject.authenticate! }
      let!(:token2) { subject.authenticate! }

      it { expect(token1).to_not eq(token2) }
    end
  end
end
