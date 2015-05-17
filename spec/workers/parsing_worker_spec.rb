require 'rails_helper'

describe '#perform(str)' do
  it 'parses xml string and populates database' do
    xml = '<?xml version="1.0" encoding="UTF-8"?>
      <data>
        <players>
          <player id="19489" name="Юрий" surname="Лодыгин" birthday="26.05.1990" height="185" weight="82" />
          <player id="3779" name="Доменико" surname="Кришито" birthday="30.12.1986" height="183" weight="75" />
          <player id="6796" name="Эсекьель" surname="Гарай" birthday="10.10.1986" height="188" weight="85" />
          <player id="19768" name="Луиш" surname="Нету" birthday="26.05.1988" height="187" weight="71" />
          <player id="264" name="Игорь" surname="Смольников" birthday="08.08.1988" height="178" weight="70"/>
          <player id="9073" name="Аксель" surname="Витсель" birthday="12.01.1989" height="183" weight="73" />
        </players>
        <events>
          <event id="200054" action="goal" player_id="264" half="1" second="337" pos_x="23,9" pos_y="64,7" />
          <event id="200055" action="free_kick" player_id="264" half="1" second="350" pos_x="21,9" pos_y="66,7" />
          <event id="200056" action="foul" player_id="264" half="1" second="380" pos_x="16,9" pos_y="70,7" />
          <event id="200057" action="foul" player_id="264" half="2" second="380" pos_x="36,9" pos_y="40,7" />
        </events>
      </data>'
      
    work = ParsingWorker.new
    work.perform(xml)

    expect(Player.count).to eq(6)
    expect(Player.find_by(first_name: "Юрий",     surname: "Лодыгин",    birthday: "1990-05-26", height: 185, weight: 82)).to eq(Player.find(19489))
    expect(Player.find_by(first_name: "Доменико", surname: "Кришито",    birthday: "1986-12-30", height: 183, weight: 75)).to eq(Player.find(3779))
    expect(Player.find_by(first_name: "Эсекьель", surname: "Гарай",      birthday: "1986-10-10", height: 188, weight: 85)).to eq(Player.find(6796))
    expect(Player.find_by(first_name: "Луиш",     surname: "Нету",       birthday: "1988-05-26", height: 187, weight: 71)).to eq(Player.find(19768))
    expect(Player.find_by(first_name: "Игорь",    surname: "Смольников", birthday: "1988-08-08", height: 178, weight: 70)).to eq(Player.find(264))
    expect(Player.find_by(first_name: "Аксель",   surname: "Витсель",    birthday: "1989-01-12", height: 183, weight: 73)).to eq(Player.find(9073))
    expect(Player.find(264).events.count).to eq(4)
    expect(Event.find_by(action: :goal,      player_id: 264, half: 1, second: 337, pos_x: 23.9, pos_y: 64.7)).to eq(Event.find(200054))
    expect(Event.find_by(action: :free_kick, player_id: 264, half: 1, second: 350, pos_x: 21.9, pos_y: 66.7)).to eq(Event.find(200055))
    expect(Event.find_by(action: :foul,      player_id: 264, half: 1, second: 380, pos_x: 16.9, pos_y: 70.7)).to eq(Event.find(200056))
    expect(Event.find_by(action: :foul,      player_id: 264, half: 2, second: 380, pos_x: 36.9, pos_y: 40.7)).to eq(Event.find(200057))
  end
end
