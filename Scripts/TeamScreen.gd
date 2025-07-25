extends Control

@onready var player_list = $VBoxContainer/ScrollContainer/PlayerList

var players: Array = []

func _ready():
    load_dummy_data()
    update_list()

func load_dummy_data():
    var p1 = PlayerData.new()
    p1.nickname = "DarkSlayer"
    p1.role = PlayerData.Role.MID
    p1.skill_mechanics = 78
    p1.skill_macro = 65
    p1.morale = 85
    p1.energy = 90

    var p2 = PlayerData.new()
    p2.nickname = "FrostMage"
    p2.role = PlayerData.Role.SUPPORT
    p2.skill_mechanics = 60
    p2.skill_macro = 80
    p2.morale = 88
    p2.energy = 85

    players = [p1, p2]

func update_list():
    for c in player_list.get_children():
        c.queue_free()

    for p in players:
        var card = preload("res://UI/PlayerCard.tscn").instantiate()
        card.get_node("LabelName").text = p.nickname
        card.get_node("LabelRole").text = role_to_text(p.role)
        card.get_node("LabelStats").text = "Мех: %d | Макро: %d" % [p.skill_mechanics, p.skill_macro]
        card.get_node("LabelState").text = "Мораль: %d | Энергия: %d" % [p.morale, p.energy]
        player_list.add_child(card)

func role_to_text(role):
    match role:
        PlayerData.Role.CARRY:
            return "Керри"
        PlayerData.Role.MID:
            return "Мид"
        PlayerData.Role.OFFLANE:
            return "Оффлейн"
        PlayerData.Role.SUPPORT:
            return "Саппорт"
        PlayerData.Role.HARD_SUPPORT:
            return "Хард саппорт"
        _:
            return "?"
