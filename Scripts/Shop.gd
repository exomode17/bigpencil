extends Control

func _ready():
    for item in GameState.shop_items:
        var row = HBoxContainer.new()
        var label = Label.new()
        label.text = item.name + " | Цена: $" + str(item.price) + " | Уровень: " + str(item.level)
        row.add_child(label)

        var btn = Button.new()
        btn.text = "Улучшить ($" + str(item.level * 500) + ")"
        btn.pressed.connect(func():
            var cost = item.level * 500
            if GameState.balance >= cost:
                GameState.balance -= cost
                item.level += 1
                GameState.save_data()
                get_tree().reload_current_scene()
        )
        row.add_child(btn)
        $VBox.add_child(row)
