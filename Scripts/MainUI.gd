extends Control

@onready var lbl_week = $MarginContainer/VBoxContainer/TopBar/lbl_week
@onready var lbl_balance = $MarginContainer/VBoxContainer/TopBar/lbl_balance
@onready var lbl_messages = $MarginContainer/VBoxContainer/TopBar/lbl_messages
@onready var content_panel = $MarginContainer/VBoxContainer/MainContent/ContentPanel/DynamicContent

var current_week := 1
var unread_messages := 3

func _ready():
	ScreenManager.content_panel = content_panel
	update_top_bar()
	ScreenManager.show_screen("res://Scenes/TeamScreen.tscn")

func update_top_bar():
	lbl_week.text = "📆 Неделя %d" % current_week
	lbl_balance.text = "💰 $" + String(var_to_str(GameState.balance))
	lbl_messages.text = "💬 Сообщения (%d)" % unread_messages

func _on_btn_home_pressed():
	ScreenManager.show_screen("res://Scenes/TeamScreen.tscn")

func _on_btn_training_pressed():
	ScreenManager.show_screen("res://Scenes/TrainingScreen.tscn")

func _on_btn_tournament_pressed():
	ScreenManager.show_screen("res://Scenes/TournamentScreen.tscn")

func _on_btn_next_week_pressed():
	GameState.simulate_week()

func _ready():
	ScreenManager.content_panel = content_panel
	GameState.event_popup = $EventPopup
	RandomEvents.event_triggered.connect(_on_random_event_triggered)
	update_top_bar()
	ScreenManager.show_screen("res://Scenes/TeamScreen.tscn")

func _on_random_event_triggered(e):
	$EventPopup.show_event(e)

func _on_btn_new_season_pressed():
	GameState.start_new_season()
	update_top_bar()
