RSpec.describe Authentication::Omniauth::SignInOrRegister do
  let(:result)   { described_class.call(params) }
  let(:identity) { result.identities.first }
  let(:profiling_user) { Profiling::User.find(result.id) }

  describe '.call' do
    context 'with valid params' do
      let(:params) { build(:omniauth_params) }

      it 'returns a valid instance of User class' do
        expect(result).to be_an_instance_of Authentication::User
        expect(result.valid?).to eq true
      end

      it 'assigns email, first_name, last_name and password to the instance' do
        expect(result.email).to eq params[:info][:email]
        expect(result.encrypted_password).to be_present
        expect(profiling_user.email).to eq params[:info][:email]
        expect(profiling_user.first_name).to eq params[:info][:first_name]
        expect(profiling_user.last_name).to eq params[:info][:last_name]
      end

      it 'links identity to the instance' do
        expect(identity).not_to be_nil
        expect(identity.user).to eq result
      end

      it 'assigns uid and provider attributes to the identity' do
        expect(identity.uid).to eq params[:uid]
        expect(identity.provider).to eq params[:provider].to_s
      end
    end

    context 'when twitter params' do
      let(:params) { build(:twitter_params) }

      it 'returns a valid instance of User class' do
        expect(result).to be_an_instance_of Authentication::User
        expect(result.valid?).to eq true
      end

      it 'assigns email, first_name, last_name and password to the instance' do
        expect(result.email).to eq params[:info][:email]
        expect(result.encrypted_password).to be_present

        expect(profiling_user.first_name).to be_present
        expect(profiling_user.last_name).to be_present
      end

      it 'links identity to the instance' do
        expect(identity).not_to be_nil
        expect(identity.user).to eq result
      end

      it 'assigns uid and provider attributes to the identity' do
        expect(identity.uid).to eq params[:uid]
        expect(identity.provider).to eq params[:provider].to_s
      end
    end

    context 'when facebook params' do
      let(:params) { build(:facebook_params) }

      it 'returns a valid instance of User class' do
        expect(result).to be_an_instance_of Authentication::User
        expect(result.valid?).to eq true
      end

      it 'assigns email, first_name, last_name and password to the instance' do
        expect(result.email).to eq params[:info][:email]
        expect(result.encrypted_password).to be_present

        expect(profiling_user.first_name).to be_present
        expect(profiling_user.last_name).to be_present
      end

      it 'links identity to the instance' do
        expect(identity).not_to be_nil
        expect(identity.user).to eq result
      end

      it 'assigns uid and provider attributes to the identity' do
        expect(identity.uid).to eq params[:uid]
        expect(identity.provider).to eq params[:provider].to_s
      end
    end

    context 'when github params' do
      let(:params) { build(:github_params) }

      it 'returns a valid instance of User class' do
        expect(result).to be_an_instance_of Authentication::User
        expect(result.valid?).to eq true
      end

      it 'assigns email, first_name, last_name and password to the instance' do
        expect(result.email).to eq params[:info][:email]
        expect(result.encrypted_password).to be_present

        expect(profiling_user.first_name).to be_present
        expect(profiling_user.last_name).to be_present
      end

      it 'links identity to the instance' do
        expect(identity).not_to be_nil
        expect(identity.user).to eq result
      end

      it 'assigns uid and provider attributes to the identity' do
        expect(identity.uid).to eq params[:uid]
        expect(identity.provider).to eq params[:provider].to_s
      end
    end

    context 'with invalid params' do
      let(:params) { {} }

      it 'returns nil' do
        expect(result).to be nil
      end
    end
  end
end
