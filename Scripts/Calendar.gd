extends Control

func _ready():
    var days = ["Понедельник", "Вторник", "Среда", "Четверг", "Пятница", "Суббота", "Воскресенье"]
    var events = GameState.get("weekly_events", [])
    if events.empty():
        events = []
        for i in range(7):
            var d = days[i]
            if d == "Пятница":
                events.append({ "day": d, "type": "Матч" })
            else:
                    GameState.stats.losses += 1
                    for p in GameState.team_players:
                        if not p.has("stats"): p.stats = { "played": 0, "wins": 0 }
                        p.stats.played += 1
                events.append({ "day": d, "type": "Тренировка" })
        GameState.weekly_events = events
        GameState.save_data()

    for e in events:
        var row = HBoxContainer.new()
        var label = Label.new()
        label.text = e.day + ": " + e.type
        row.add_child(label)

        var btn = Button.new()
        btn.text = "Выполнить"
        btn.pressed.connect(func():
            if e.type == "Матч":
                var win = randf() < 0.5
                if win:
                    GameState.stats.wins += 1
                    for p in GameState.team_players:
                        if not p.has("stats"): p.stats = { "played": 0, "wins": 0 }
                        p.stats.played += 1
                        p.stats.wins += 1
                    GameState.balance += 500
                    GameState.team_rating += 1
                    GameState.fans += 200
                    GameState.financial_history.append({ "week": GameState.week, "type": "Победа в матче", "amount": 500 })
                else:
                    GameState.stats.losses += 1
                    for p in GameState.team_players:
                        if not p.has("stats"): p.stats = { "played": 0, "wins": 0 }
                        p.stats.played += 1
                    GameState.fans += 50
                GameState.save_data()
                get_tree().reload_current_scene()
            elif e.type == "Тренировка":
                GameState.team_rating += 0.25
                GameState.save_data()
                get_tree().reload_current_scene()
        )
        row.add_child(btn)
        $VBox.add_child(row)
