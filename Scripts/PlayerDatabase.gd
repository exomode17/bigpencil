extends Node

var players: Array = []

func _ready():
    # Тестовый состав
    var p1 = PlayerData.new()
    p1.nickname = "DarkSlayer"
    p1.skill_mechanics = 78
    p1.skill_macro = 65
    p1.is_active = true

    var p2 = PlayerData.new()
    p2.nickname = "FrostMage"
    p2.skill_mechanics = 60
    p2.skill_macro = 80
    p2.is_active = true

    players = [p1, p2]
