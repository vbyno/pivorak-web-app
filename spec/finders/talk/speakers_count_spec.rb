require 'rails_helper'

RSpec.describe Talk::SpeakersCount do
  let(:user_id_1) { SecureRandom.uuid }
  let(:user_id_2) { SecureRandom.uuid }
  let!(:talk)  { create(:talk, speaker_id: user_id_1) }
  let!(:talk2) { create(:talk, speaker_id: user_id_2) }
  let!(:talk3) { create(:talk, speaker_id: user_id_2) }

  it 'count only users with some talks' do
    expect(described_class.call).to eq 2
  end
end
