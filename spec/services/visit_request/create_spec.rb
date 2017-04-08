require 'rails_helper'

describe VisitRequest::Create do
  let(:event) { create(:event) }
  let(:user_id) { '624f6dd0-91f2-4026-a684-01924da4be84' }

  subject { described_class.new(user_id, event) }

  describe '#call' do
    context 'user is verified' do
      before { create(:profiling_user, :verified, id: user_id) }

      context 'event has free slots for verified users' do
        before do
          allow_any_instance_of(Event::SlotsPolicy).to receive(:has_free_slot_for?).with(user_id) { true }
          subject.call
        end

        it { expect(event.visit_requests).to have(1).item }
        it { expect(event.visit_requests.last).to be_approved }
        it { expect(event.visit_requests.last).to_not be_waiting_list }
      end

      context 'event has no free slots for verified users' do
        before do
          allow_any_instance_of(Event::SlotsPolicy).to receive(:has_free_slot_for?).with(user_id) { false }

          expect(VisitRequestMailer).not_to receive(:unverified_attendee)

          subject.call
        end

        it { expect(event.visit_requests).to have(1).item }
        it { expect(event.visit_requests.last).to be_pending }
        it { expect(event.visit_requests.last).to be_waiting_list }
      end
    end

    context 'user is not verified' do
      before { create(:profiling_user, verified: false, id: user_id) }

      context 'event has free slots for newbies' do
        before do
          allow_any_instance_of(Event::SlotsPolicy).to receive(:has_free_slot_for?).with(user_id) { true }

          mailer = double('mailer')
          expect(VisitRequestMailer).to receive(:unverified_attendee) { mailer }
          expect(mailer).to receive(:deliver_later)

          subject.call
        end

        it { expect(event.visit_requests).to have(1).item }
        it { expect(event.visit_requests.last).to be_pending }
        it { expect(event.visit_requests.last).to_not be_waiting_list }
      end

      context 'event has no free slots for newbies' do
        before do
          allow_any_instance_of(Event::SlotsPolicy).to receive(:has_free_slot_for?).with(user_id) { false }
          subject.call
        end

        it { expect(event.visit_requests).to have(1).item }
        it { expect(event.visit_requests.last).to be_pending }
        it { expect(event.visit_requests.last).to be_waiting_list }
      end
    end
  end
end
