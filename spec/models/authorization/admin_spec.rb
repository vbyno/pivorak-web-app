RSpec.describe Authorization::Admin, type: :model do
  it { is_expected.to validate_presence_of(:id) }
end
