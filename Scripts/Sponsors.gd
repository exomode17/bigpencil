extends Control

func _ready():
    for sponsor in GameState.sponsors_available:
        var row = HBoxContainer.new()
        var label = Label.new()
        label.text = sponsor.name + " | $" + str(sponsor.weekly) + "/нед. | " + str(sponsor.duration) + " недель"
        row.add_child(label)

        var btn = Button.new()
        btn.text = "Подписать"
        btn.pressed.connect(func():
            GameState.active_sponsors.append(sponsor)
            GameState.sponsors_available.erase(sponsor)
            GameState.save_data()
            get_tree().reload_current_scene()
        )
        row.add_child(btn)
        $VBox.add_child(row)
