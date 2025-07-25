extends Control

func _ready():
    for child in $Grid.get_children():
        if child is TextureButton:
            child.pressed.connect(func():
                GameState.team_logo = child.texture_normal
                GameState.save_data()
                get_tree().change_scene_to_file("res://Scenes/TeamCustomization.tscn")
            )
