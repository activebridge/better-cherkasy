require 'rails_helper'

RSpec.describe Event, type: :model do
  subject { FactoryGirl.build(:event) }

  it { should be_valid }
end
