class SpeakersController < ApplicationController
  disabled_feature_until '1.1'

  helper_method :speakers

  private

  def speakers
    @speakers ||= Profiling::User.joins(:talks)
  end
end
