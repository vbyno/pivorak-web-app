require 'rails_helper'

describe VisitRequest::Import do
  let(:event)       { create(:event, status: :passed) }
  let!(:user_a)     { create(:profiling_user) }
  let!(:user_b)     { create(:profiling_user) }
  let!(:user_c)     { create(:profiling_user) }
  let(:separator)   { ', ' }
  let(:emails_list) { [user_a, user_b].map(&:email).join(separator) + ', fake@user.com' }

  subject { described_class.new(event, separator, emails_list) }

  describe '#call' do
    before { subject.call }

    it { expect(event.visitors.size).to eq 2 }
    it { expect(event.visitors).to include(user_a) }
    it { expect(event.visitors).to include(user_b) }
    it { expect(event.visitors).to_not include(user_c) }

    it { expect(event.visit_requests.first.user_id).to eq user_a.id }
    it { expect(event.visit_requests.first.status).to eq VisitRequest::CONFIRMED.to_s }
    it { expect(event.visit_requests.first.visited).to eq true }
  end
end
