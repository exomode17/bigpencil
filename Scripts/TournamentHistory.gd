extends Control

func _ready():
    var list = GameState.get("tournament_history", [])
    if list.empty():
        var l = Label.new()
        l.text = "История турниров пока пуста"
        add_child(l)
        return

    for t in list:
        var l = Label.new()
        var text = "Неделя " + str(t.week) + ": Победитель — " + t.winner
        if t.player_participated:
            text += ", вы заняли " + str(t.player_place) + " место"
            l.add_theme_color_override("font_color", Color.cyan)
        l.text = text
        add_child(l)
