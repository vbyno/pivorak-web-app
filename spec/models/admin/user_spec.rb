RSpec.describe Admin::User do
  let(:user_id) { '624f6dd0-91f2-4026-a684-01924da4be84' }
  let!(:profiling_user) { create :profiling_user, id: user_id }

  let(:user) { described_class.find(user_id) }

  describe '.default_scope' do
    it 'returns gathered objects' do
      expect(user.admin?).to be false
      expect(user.synthetic?).to be true
      expect(user.verified?).to be false
    end
  end

  describe '.admin' do
    subject(:admin) { described_class.admin.size }

    context 'no admin user' do
      it { is_expected.to be_zero }
    end

    context 'admin user exists' do
      let!(:authorization_admin) { create :authorization_admin, id: user_id }

      it { is_expected.to eq 1 }
    end
  end

  describe '#admin?' do
    specify { expect(user.admin?).to be false }

    context 'authorization_admin exists' do
      let!(:authorization_admin) { create :authorization_admin, id: user_id }

      specify { expect(user.admin?).to be true }
    end
  end

  describe '#synthetic?' do
    specify { expect(user.synthetic?).to be true }

    context 'authentication_user exists' do
      let!(:authentication_user) { create :authentication_user, id: user_id }

      specify { expect(user.synthetic?).to be false }
    end
  end

  describe '#verified?' do
    specify { expect(user.verified?).to be false }

    context 'user is synthetic' do
      let!(:profiling_user) { create :profiling_user, :verified, id: user_id }

      specify { expect(user.verified?).to be true }
    end
  end
end
