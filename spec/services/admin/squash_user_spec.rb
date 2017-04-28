RSpec.describe Admin::SquashUser do
  let(:user_a_id) { SecureRandom.uuid }
  let(:user_b_id) { SecureRandom.uuid }
  let(:valid_params) { { squashed_user_id: user_a_id, into_user_id: user_b_id } }

  describe '.call' do
    let!(:identity)      { create :identity,      user_id: user_a_id }
    let!(:donation)      { create :donation,      user_id: user_a_id }
    let!(:talk)          { create :talk,       speaker_id: user_a_id }
    let!(:visit_request) { create :visit_request, user_id: user_a_id }

    context 'user_b got dependencies of user_a' do
      before { described_class.call(valid_params) }

      it { expect(identity.reload.user_id).to eq user_b_id }
      it { expect(donation.reload.user_id).to eq user_b_id }
      it { expect(talk.reload.speaker_id).to eq user_b_id }
      it { expect(visit_request.reload.user_id).to eq user_b_id }
    end

    it 'destroys profiling user' do
      user = create :profiling_user, id: user_a_id

      described_class.call(valid_params)

      expect { user.reload }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end

  describe '#schema' do
    let(:invalid_params) { { squashed_user_id: nil, into_user_id: nil } }
    let(:stupid_params)  { { squashed_user_id: user_a_id, into_user_id: user_a_id } }

    it { expect(described_class.call(valid_params)).to_not be_nil }
    it { expect(described_class.call(invalid_params)).to be_nil }
    it { expect(described_class.call(stupid_params)).to be_nil }
  end

  describe '#dependencies' do
    let(:expected_dependencies) {
      {
        has_many: {
          Identity     => :user_id,
          Donation     => :user_id,
          Talk         => :speaker_id,
          VisitRequest => :user_id
        }
      }
    }

    it { expect(described_class.new.dependencies).to eq expected_dependencies }
  end
end
