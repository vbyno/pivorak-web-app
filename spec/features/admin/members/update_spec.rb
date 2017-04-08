RSpec.describe 'Members UPDATE' do
  let(:user_id) { '624f6dd0-91f2-4026-a684-01924da4be84' }
  let!(:member) { create(:profiling_user, id: user_id, email: 'tester@example.com') }

  before do
    assume_admin_logged_in(user_id)
    visit "/admin/members/#{member.id}/edit"
  end

  context 'invalid input' do
    it 'validates title presence' do
      fill_in 'Email', with: ''
      click_button 'Update User'

      expect_an_error member_email: :blank
      expect_error_flash_message 'Member', 'updated'
    end
  end

  context 'valid input' do
    it 'create new user' do
      fill_in 'Email', with: 'another@example.com'
      click_button 'Update User'

      expect(page).to have_current_path "/admin/members/#{member.slug}/edit"
      expect_success_flash_message 'Member', 'updated'
    end

    it 'updates user to admin' do
      check 'member_admin'
      click_button 'Update User'

      expect(member.reload.admin).to be_truthy
    end
  end
end
