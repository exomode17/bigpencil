extends Control

var scouted := false

func _ready():
    if GameState.has("scouted_week") and GameState.scouted_week == GameState.week:
        scouted = true

    var label = Label.new()
    label.text = scouted ? "Скаутинг уже проведён на этой неделе" : "Выберите команду для анализа:"
    $VBox.add_child(label)

    if not scouted:
        for name in ["Team A", "Team B", "Team C", "Team D", "Team E", "Team F", "Team G"]:
            var row = HBoxContainer.new()
            var info = Label.new()
            info.text = name + " | Рейтинг: " + str(round(60 + randf() * 40, 1)) + " | Стиль: " + ["Агрессия", "Фарм", "Микро"][randi() % 3]
            row.add_child(info)
            var btn = Button.new()
            btn.text = "Скаутить"
            btn.pressed.connect(func():
                GameState.scouted_week = GameState.week
                GameState.next_match_bonus = 10
                GameState.save_data()
                get_tree().reload_current_scene()
            )
            row.add_child(btn)
            $VBox.add_child(row)
    else:
        var l = Label.new()
        l.text = "Вы получите +10 к рейтингу на следующий матч!"
        $VBox.add_child(l)
