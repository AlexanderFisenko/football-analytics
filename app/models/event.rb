class Event < ActiveRecord::Base
  extend Enumerize

  belongs_to :player

  enumerize :action, in: [:goal, :free_kick, :foul]

  scope :goals,      -> { where(action: 'goal') }
  scope :free_kicks, -> { where(action: 'free_kick') }
  scope :fouls,      -> { where(action: 'foul') }


  def minute
    offset = half == 1 ? 0 : 45
    offset + (second / 60).round
  end


end
