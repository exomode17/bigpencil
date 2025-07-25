extends Node

var content_panel: Control = null

func show_screen(path: String):
	if content_panel:
		for c in content_panel.get_children():
			c.queue_free()
		var screen = load(path).instantiate()
		content_panel.add_child(screen)
