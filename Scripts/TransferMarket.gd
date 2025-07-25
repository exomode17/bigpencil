extends Control

var market = [
    {"name": "Iceberg", "role": "Mid", "rating": 78, "salary": 400},
    {"name": "Zayac", "role": "Support", "rating": 75, "salary": 350},
    {"name": "Ramzes", "role": "Carry", "rating": 82, "salary": 500},
    {"name": "No[o]ne", "role": "Mid", "rating": 80, "salary": 470},
    {"name": "Save-", "role": "Support", "rating": 76, "salary": 360},
]

func _ready():
    for player in market:
        var node = $VBox.get_node(player.name)
        var btn = node.get_node("ButtonHire")
        btn.pressed.connect(func():
            if GameState.balance >= player.salary:
                GameState.balance -= player.salary
                GameState.team_players.append(player)
                GameState.save_data()
                btn.disabled = true
                btn.text = "Подписан"
            else:
                btn.text = "Недостаточно средств"
        )
