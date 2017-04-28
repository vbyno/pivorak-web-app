require 'rails_helper'

RSpec.describe Authentication::User::IncreasingPerMonth do
  let!(:user)  { create(:authentication_user, created_at: Time.zone.now - 1.month) }
  let!(:user2) { create(:authentication_user, created_at: Time.zone.now) }
  let!(:user3) { create(:authentication_user, created_at: Time.zone.now + 1.month) }

  it 'last should eq sum of all' do
    expect(described_class.call.values.last).to eq 3
  end
end
