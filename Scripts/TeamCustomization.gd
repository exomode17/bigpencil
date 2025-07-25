extends Control

@onready var name_input = $VBoxContainer/LineEditTeamName
@onready var color_picker = $VBoxContainer/ColorPicker
@onready var btn_save = $VBoxContainer/ButtonSave

func _ready():
    name_input.text = GameState.team_name
    color_picker.color = GameState.team_color
    btn_save.pressed.connect(_on_save_pressed)

func _on_save_pressed():
    GameState.team_name = name_input.text
    GameState.team_color = color_picker.color
    GameState.save_data()
    get_tree().change_scene_to_file("res://Scenes/MainUI.tscn")

func _on_LabelLogo_gui_input(event):
    if event is InputEventMouseButton and event.pressed:
        get_tree().change_scene_to_file("res://Scenes/LogoPicker.tscn")
