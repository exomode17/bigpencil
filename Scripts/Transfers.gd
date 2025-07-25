extends Control

func _ready():
    for p in GameState.free_agents:
        var row = HBoxContainer.new()
        var label = Label.new()
        var cost = p.rating * 150
        var salary = p.rating * 7
        label.text = p.name + " (" + p.role + ") | Рейтинг: " + str(p.rating) + " | Выкуп: $" + str(cost)
        row.add_child(label)

        var btn = Button.new()
        btn.text = "Подписать ($" + str(cost) + ")"
        btn.pressed.connect(func():
            if GameState.balance >= cost:
                GameState.balance -= cost
                p.salary = salary
                GameState.team_players.append(p)
                GameState.free_agents.erase(p)
                GameState.financial_history.append({ "week": GameState.week, "type": "Трансфер: " + p.name, "amount": -cost })
                GameState.save_data()
                get_tree().reload_current_scene()
        )
        row.add_child(btn)
        $VBox.add_child(row)
