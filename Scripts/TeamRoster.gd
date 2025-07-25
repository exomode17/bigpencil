extends Control

func _ready():
    var total = 0
    for player in GameState.team_players:
        var row = HBoxContainer.new()
        var label = Label.new()
        label.text = player.name + " (" + player.role + ") | Рейтинг: " + str(player.rating) + " | З/п: $" + str(player.salary)
        row.add_child(label)

        var btn = Button.new()
        btn.text = "Уволить"
        btn.pressed.connect(func():
            GameState.team_players.erase(player)
            GameState.save_data()
            get_tree().reload_current_scene()
        )
        row.add_child(btn)

        $VBox.add_child(row)
        total += player.salary

    var summary = Label.new()
    summary.text = "Суммарная зарплата: $" + str(total)
    $VBox.add_child(summary)
