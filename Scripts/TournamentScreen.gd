extends Control

@onready var match_list = $VBoxContainer/MatchList
@onready var button_sim = $VBoxContainer/ButtonSimulate
@onready var title = $VBoxContainer/Label

var all_teams = []

func generate_teams():
	all_teams = ["PlayerTeam"]
	while all_teams.size() < 8:
		var name = TeamNameGenerator.generate_team_name()
		if name not in all_teams:
			all_teams.append(name)
	"PlayerTeam", "EnemyTeam1", "EnemyTeam2", "EnemyTeam3",
	"EnemyTeam4", "EnemyTeam5", "EnemyTeam6", "EnemyTeam7"
]

var current_round := 1
var active_matches := []
var history := []
var reward_amount := 50000

func _ready():
	generate_teams()
	start_round()
	button_sim.connect("pressed", Callable(self, "_on_simulate_pressed"))

func start_round():
	title.text = "🏆 Турнир: Этап %d" % current_round
	active_matches.clear()
	match_list.queue_free_children()

	var pairs = []
	for i in range(0, all_teams.size(), 2):
		pairs.append({
			"team_a": all_teams[i],
			"team_b": all_teams[i+1],
			"result": null
		})
	active_matches = pairs
	render_matches()

func render_matches():
	match_list.queue_free_children()
	for m in active_matches:
		var label = Label.new()
		var res = m.result if m.result != null else "?"
		label.text = "%s vs %s  →  %s" % [m.team_a, m.team_b, res]
		match_list.add_child(label)

func _on_simulate_pressed():
	var winners = []

	for m in active_matches:
		if m.result == null:
			var winner = MatchSimulator.simulate(m.team_a, m.team_b)
			m.result = winner
		winners.append(m.result)

	render_matches()

	if winners.size() == 1:
		var champ = winners[0]
		title.text = "🏆 Победитель турнира: " + champ
		GameState.add_history_entry(champ)
		button_sim.disabled = true
		update_history_display()

		if champ == "PlayerTeam":
			GameState.balance += reward_amount
			title.text += " (+$%d)" % reward_amount
	else:
		all_teams = winners
		current_round += 1
		await get_tree().create_timer(1.0).timeout
		start_round()


func update_history_display():
	var history_list = $VBoxContainer/HistoryList
	history_list.queue_free_children()

	for i in range(history.size()):
		var entry = Label.new()
		entry.text = "%d. %s" % [i + 1, history[i]]
		history_list.add_child(entry)
