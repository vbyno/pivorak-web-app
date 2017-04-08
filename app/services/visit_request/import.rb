class VisitRequest
  class Import < ApplicationService
    def initialize(event, separator, emails_list)
      @event       = event
      @separator   = separator.strip
      @emails_list = emails_list
    end

    def call
      emails_list.split(separator).each do |email|
        user = Profiling::User.find_by(email: email.strip)
        next unless user

        event.visit_requests.where(
          user_id: user,
          status: :confirmed,
          visited: true
        ).first_or_create
      end
    end

    private

    attr_reader :event, :emails_list, :separator
  end
end
