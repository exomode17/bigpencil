extends Control

var player

@onready var lbl_name = $VBoxContainer/LabelName
@onready var lbl_role = $VBoxContainer/LabelRole
@onready var lbl_stats = $VBoxContainer/LabelStats
@onready var lbl_state = $VBoxContainer/LabelMoraleEnergy
@onready var btn_back = $VBoxContainer/ButtonBack

func _ready():
    btn_back.connect("pressed", Callable(self, "_on_back_pressed"))
    update_ui()

func update_ui():
    if player == null:
        return
    lbl_name.text = "Ник: " + player.nickname
    lbl_role.text = "Роль: " + role_to_text(player.role)
    lbl_stats.text = "Мех: %d, Макро: %d" % [player.skill_mechanics, player.skill_macro]
    lbl_state.text = "Мораль: %d, Энергия: %d" % [player.morale, player.energy]

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

func _on_back_pressed():
    ScreenManager.show_screen("res://Scenes/TeamScreen.tscn")
