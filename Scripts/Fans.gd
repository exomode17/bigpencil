extends Control

func _ready():
    var label = Label.new()
    label.text = "Фанатов: " + str(GameState.fans)
    $VBox.add_child(label)

    var desc = Label.new()
    desc.text = "Фан-база растёт от побед, турниров, PR-активности."
    $VBox.add_child(desc)
