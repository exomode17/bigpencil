extends Control

var upgrade_costs = {
    "base": 1000,
    "bootcamp": 800,
    "analytics": 600,
    "pr": 500
}

func _ready():
    for key in GameState.infrastructure.keys():
        var node = $VBox.get_node(key)
        if node:
            var level_label = node.get_node("Level")
            level_label.text = str(GameState.infrastructure[key])
            var btn = node.get_node("ButtonUpgrade")
            btn.pressed.connect(func():
                var cost = upgrade_costs[key]
                if GameState.balance >= cost:
                    GameState.balance -= cost
                    GameState.infrastructure[key] += 1
                    GameState.save_data()
                    level_label.text = str(GameState.infrastructure[key])
                else:
                    btn.text = "Недостаточно $"
            )
