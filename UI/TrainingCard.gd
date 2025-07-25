extends HBoxContainer

var player
var selected_training := 0

func setup(p):
	player = p
	$LabelName.text = p.nickname
	update_energy_preview()
	$OptionButton.connect("item_selected", Callable(self, "_on_option_selected"))

func _on_option_selected(index):
	selected_training = index
	update_energy_preview()

func update_energy_preview():
	var energy_loss := 0
	match selected_training:
		1:
			energy_loss = 15
		2:
			energy_loss = 10
		3:
			energy_loss = 5
		_:
			energy_loss = 0

	$LabelEnergy.set_text("Энергия: %d → %d" % [player.energy, max(0, player.energy - energy_loss)])

func apply_training():
	match selected_training:
		1:
			player.skill_mechanics += 1
			player.energy -= 15
			player.morale -= 5
		2:
			player.skill_macro += 1
			player.energy -= 10
			player.morale -= 3
		3:
			player.morale += 5
			player.energy -= 5

func _on_ButtonView_pressed():
	var screen = load("res://Scenes/PlayerDetails.tscn").instantiate()
	screen.player = player
	ScreenManager.content_panel.free_children()
	ScreenManager.content_panel.add_child(screen)
