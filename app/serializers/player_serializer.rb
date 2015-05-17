class PlayerSerializer < ActiveModel::Serializer
  attributes :id, :name, :age, :height, :weight, :events, :avg_pos_x, :avg_pos_y
  
  def events
    {
      goal:      [{ id: object.last_goal.id,      minute: object.last_goal.minute }],
      free_kick: [{ id: object.last_free_kick.id, minute: object.last_free_kick.minute }],
      foul:      [{ id: object.last_foul.id,      minute: object.last_foul.minute }]
    }
  end

  def height
    value  = object.height / 30.48
    parts  = value.modulo(1)
    feet   = value.round
    inches = (parts * 12).round

    return inches != 0 ? "#{feet} feet #{inches} inches" : "#{feet} feet"
  end

  def weight
    pounds = (object.weight * 2.20462262).round
    return "#{pounds} pounds"
  end

end
