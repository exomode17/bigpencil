extends Control

@onready var player_list = $VBoxContainer/ScrollContainer/PlayerList
@onready var btn_apply = $VBoxContainer/ButtonApply

var players: Array = []

func _ready():
    load_dummy_data()
    update_list()
    btn_apply.connect("pressed", Callable(self, "_on_apply_pressed"))

func load_dummy_data():
    var p1 = PlayerData.new()
    p1.nickname = "DarkSlayer"
    p1.energy = 90
    p1.morale = 80
    players.append(p1)

    var p2 = PlayerData.new()
    p2.nickname = "FrostMage"
    p2.energy = 85
    p2.morale = 88
    players.append(p2)

func update_list():
    for c in player_list.get_children():
        c.queue_free()

    for p in players:
        var card = preload("res://UI/TrainingCard.tscn").instantiate()
        card.setup(p)
        player_list.add_child(card)

func _on_apply_pressed():
    for card in player_list.get_children():
        card.apply_training()
    update_list()
