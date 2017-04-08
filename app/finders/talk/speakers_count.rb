class Talk::SpeakersCount < ApplicationFinder
  def call
    Talk.select('DISTINCT speaker_id').count
  end
end
