На эндпойнт /incoming/ приходят POST-запросом данные в следующем формате:

<?xml version="1.0" encoding="UTF-8"?>
<data>
<players>
  <player id="19489" name="Юрий" surname="Лодыгин" birthday="26.05.1990" height="185" weight="82" />
  <player id="3779" name="Доменико" surname="Кришито" birthday="30.12.1986" height="183" weight="75" />
  <player id="6796" name="Эсекьель" surname="Гарай" birthday="10.10.1986" height="188" weight="85" />
  <player id="19768" name="Луиш" surname="Нету" birthday="26.05.1988" height="187" weight="71" />
  <player id="264" name="Игорь" surname="Смольников" birthday="08.08.1988" height="178" weight="70"/>
  <player id="9073" name="Аксель" surname="Витсель" birthday="12.01.1989" height="183" weight="73" />
<events>
  <event id="200054" action="goal" player_id="9073" half="1" second="337" pos_x="23,9" pos_y="64,7" />
  <event id="200055" action="free_kick" player_id="3779" half="1" second="350" pos_x="21,9" pos_y="66,7" />
  <event id="200056" action="foul" player_id="9073" half="1" second="380" pos_x="16,9" pos_y="70,7" />
  <event id="200057" action="foul" player_id="9073" half="2" second="380" pos_x="36,9" pos_y="40,7" />
</events>
</data>

Нужно записывать эти данные в БД; если найден игрок/событие с тем же id, то обновлять эти данные, если нет — то записывать нового игрока/событие. 

Задача — вывести данные по каждому игроку (актуальные на данный момент времени) в JSON вида: players/19489.json

{
  "id": "19489", "name": "Yuri Lodygin", "age": 25, "height": "6 feet 2 inches", "weight": "235 pounds",
  "events": {
    "goal": [
      { "id": "200054", "minute": 6 }
    ],
    "free_kick": [
      ...
    ],
    "foul": [
      ...
    ]
  },
  "avg_pos_x": 23.9, "avg_pos_y": 64.7
}

Имя транслитерируется с кириллицы на латиницу, рост пересчитывается в футы, вес — в фунты, события для этого игрока стурктурированы по типу, внутри указана минута, на которой произошло событие. В конце вывода по игроку — среднее положение по координатам по всем событиям с его участием.

Большим плюсом будет, если задача на парсинг XML будет выполняться асинхронно (Sidekiq), и если будет тестовое покрытие (RSpec). Результат выполения задания очень хочется получить в виде git-репозитория.