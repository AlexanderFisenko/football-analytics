class Player < ActiveRecord::Base
  has_many :events, dependent: :destroy

  def name
    "#{first_name} #{surname}"
  end

  def height_in_feet
    value  = height / 30.48
    parts  = value.modulo(1)
    feet   = value.round
    inches = (parts * 12).round

    return inches != 0 ? "#{feet} feet #{inches} inches" : "#{feet} feet"
  end

  def weight_in_pounds
    pounds = (weight * 2.20462262).round
    return "#{pounds} pounds"
  end

  def age
    now = Time.now.utc.to_date
    now.year - birthday.year - (birthday.to_date.change(year: now.year) > now ? 1 : 0)
  end

  def avg_pos_x
    (events.sum(:pos_x) / events.size).round(1)
  end

  def avg_pos_y
    (events.sum(:pos_y) / events.size).round(1)
  end

  def last_goal
    events.goals.order("updated_at").last
  end

  def last_free_kick
    events.free_kicks.order("updated_at").last
  end

  def last_foul
    events.fouls.order("updated_at").last
  end

end
