RSpec.describe 'Profile UPDATE' do
  context 'when user is not logged in' do
    before do
      visit '/profile/edit'
    end

    it 'responds with redirect' do
      expect(page).to have_current_path '/users/sign_in'
    end
  end

  context 'when user is logged in' do
    let(:user) { create(:profiling_user, :tester, first_name: 'John') }

    before do
      assume_logged_in(user.id)
      visit '/profile/edit'
    end

    context 'invalid input' do
      context 'when updating profile attrs' do
        it 'validates errors' do
          fill_in 'First name', with: ''
          click_button 'Update'

          expect(page).to have_content I18n.t('notifications.failure')
        end
      end
    end

    context 'valid input' do
      context 'when updates profile attrs' do
        it 'updates user' do
          email = Faker::Internet.email
          first_name = Faker::Name.name
          last_name = Faker::Name.name
          old_slug = user.slug

          fill_in 'First name', with: first_name
          fill_in 'Last name', with: last_name

          click_button 'Update'

          expect(page).to have_content I18n.t('notifications.success')

          expect(user.reload.first_name).to eq(first_name)
          expect(user.reload.last_name).to eq(last_name)
          expect(user.reload.slug).to_not eq(old_slug)
        end
      end
    end
  end
end
