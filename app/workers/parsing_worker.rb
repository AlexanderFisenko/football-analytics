class ParsingWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(str)
    xml_doc = Nokogiri::XML(str)

    players = xml_doc.css("player")

    players.each do |player|
      id = player.attributes["id"].value

      attributes              = {} 
      attributes[:first_name] = player.attributes["name"].value
      attributes[:surname]    = player.attributes["surname"].value
      attributes[:birthday]   = player.attributes["birthday"].value
      attributes[:height]     = player.attributes["height"].value
      attributes[:weight]     = player.attributes["weight"].value

      player = Player.where(id: id).first_or_initialize
      player.update(attributes)
    end

    events = xml_doc.css("event")

    events.each do |event|
      id        = event.attributes["id"].value
      player_id = event.attributes["player_id"].value

      attributes             = {}
      attributes[:action]    = event.attributes["action"].value
      attributes[:player_id] = player_id if Player.where(id: player_id).any?
      attributes[:half]      = event.attributes["half"].value
      attributes[:second]    = event.attributes["second"].value
      attributes[:pos_x]     = event.attributes["pos_x"].value.gsub(",", ".")
      attributes[:pos_y]     = event.attributes["pos_y"].value.gsub(",", ".")

      event = Event.where(id: id).first_or_initialize
      event.update(attributes)
    end
  end

end