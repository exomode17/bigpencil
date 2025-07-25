extends Control

func _ready():
    var rounds := GameState.get("tournament_grid", [])
    if rounds.empty():
        return

    var hbox = HBoxContainer.new()
    hbox.anchor_right = 1.0
    hbox.anchor_bottom = 1.0
    add_child(hbox)

    for round in rounds:
        var vbox = VBoxContainer.new()
        vbox.custom_minimum_size = Vector2(180, 0)
        for match in round:
            var label = Label.new()
            var text = match[0] + " vs " + match[1]
            if match.size() > 2:
                text += " → " + match[2]
            label.text = text
            if "YOU" in text:
                label.add_theme_color_override("font_color", Color.cyan)
            vbox.add_child(label)
        hbox.add_child(vbox)
