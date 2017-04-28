RSpec.describe 'Members READ' do
  let(:authentication_user_a) { create :authentication_user }
  let(:authentication_user_b) { create :authentication_user }
  let!(:user_a) { create(:profiling_user, id: authentication_user_a.id,
                                          first_name: 'First',
                                          last_name: 'User') }
  let!(:user_b) { create(:profiling_user, id: authentication_user_b.id,
                                          first_name: 'Second',
                                          last_name: 'User') }

  before do
    assume_admin_logged_in
    visit '/admin/members'
  end

  it { expect(page).to have_link 'First User' }
  it { expect(page).to have_link 'Second User' }
  it { expect(page).to have_link 'New Member' }
  it { expect(page).to have_link('Edit', count: 3) }
  it 'New Member click redirect to #new' do
    click_link 'New Member'
    expect(page).to have_current_path('/admin/members/new')
  end
end
