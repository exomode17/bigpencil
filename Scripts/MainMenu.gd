extends Control

func _ready():
    $VBoxContainer/ButtonContinue.disabled = not FileAccess.file_exists(GameState.SAVE_PATH)

    $VBoxContainer/ButtonContinue.pressed.connect(_on_continue_pressed)
    $VBoxContainer/ButtonNew.pressed.connect(_on_new_pressed)
    $VBoxContainer/ButtonExit.pressed.connect(_on_exit_pressed)

func _on_continue_pressed():
    get_tree().change_scene_to_file("res://Scenes/MainUI.tscn")

func _on_new_pressed():
    GameState.balance = 100000
    GameState.week = 1
    GameState.current_year = 2025
    GameState.tournament_history = []
    GameState.captain_name = ""
    GameState.infrastructure = {
        "gaming_house": 1,
        "analytics_center": 0,
        "coaching_staff": 1
    }
    GameState.save_data()
    get_tree().change_scene_to_file("res://Scenes/MainUI.tscn")

func _on_exit_pressed():
    get_tree().quit()
