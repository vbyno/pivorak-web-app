RSpec.describe 'Talks CREATE' do
  let(:user_id) { '624f6dd0-91f2-4026-a684-01924da4be84' }
  let!(:user) { create(:profiling_user, id: user_id) }

  before do
    assume_admin_logged_in(user_id)
    visit '/admin/talks/new'
  end

  context 'invalid input' do
    it 'validates errors' do
      fill_in 'Title', with: ''
      click_button 'Create Talk'

      expect_an_error talk_title:  :blank
      expect_error_flash_message 'Talk', 'created'
    end
  end

  context 'valid input' do
    it 'create new talk' do
      fill_in 'Title', with: 'Super New Talk'
      click_button 'Create Talk'

      expect_success_flash_message 'Talk', 'created'
      expect(page).to have_current_path '/admin/talks/super-new-talk/edit'
    end
  end

  context 'with tags' do
    it 'create new with tags' do
      fill_in 'Title',    with: 'Talk with Tags'
      fill_in 'Tag list', with: 'ruby rails tags'
      click_button 'Create Talk'
      visit '/admin/talks'

      expect(page).to have_content 'ruby rails tags'
    end
  end

  context 'with speaker' do
    it 'create talk with speaker' do
      fill_in 'Title',    with: 'Talk with Tags'

      select reverse_full_name, from: 'talk[speaker_id]'

      click_button 'Create Talk'

      expect(Talk.last.speaker).to eq user
    end

    def reverse_full_name
      "#{user.last_name} #{user.first_name}"
    end
  end
end
