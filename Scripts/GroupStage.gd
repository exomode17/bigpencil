extends Control

var group_A = []
var group_B = []
var results = {}

func _ready():
    if not GameState.has("group_stage"):
        var teams = ["Team A", "Team B", "Team C", "Team D", "Team E", "Team F", "Team G", "YOU"]
        teams.shuffle()
        group_A = teams.slice(0, 4)
        group_B = teams.slice(4, 4)
        results = {}
        for g in [group_A, group_B]:
            for t1 in g:
                for t2 in g:
                    if t1 != t2 and not results.has(t1 + "-" + t2) and not results.has(t2 + "-" + t1):
                        var r1 = randf() * 100
                        var r2 = randf() * 100
                        if t1 == "YOU":
                            r1 = GameState.team_rating + randf() * 10
                        if t2 == "YOU":
                            r2 = GameState.team_rating + randf() * 10
                        results[t1 + "-" + t2] = t1 if r1 > r2 else t2
        GameState.group_stage = { "A": group_A, "B": group_B, "results": results }
    else:
        group_A = GameState.group_stage["A"]
        group_B = GameState.group_stage["B"]
        results = GameState.group_stage["results"]

    draw_table(group_A, "Группа A")
    draw_table(group_B, "Группа B")

    var next = Button.new()
    next.text = "Начать плей-офф"
    next.pressed.connect(func():
        var top4 = get_top(group_A) + get_top(group_B)
        GameState.tournament_teams = top4
        GameState.tournament_round = 1
        GameState.tournament_grid = []
        GameState.erase("group_stage")
        GameState.save_data()
        get_tree().change_scene_to_file("res://Scenes/Tournament.tscn")
    )
    add_child(next)

func draw_table(group, title):
    var label = Label.new()
    label.text = title
    add_child(label)

    var scores = {}
    for t in group:
        scores[t] = 0

    for k in results.keys():
        var parts = k.split("-")
        if parts[0] in group and parts[1] in group:
            scores[results[k]] += 2

    for t in group:
        var l = Label.new()
        l.text = t + ": " + str(scores[t]) + " очков"
        if t == "YOU":
            l.add_theme_color_override("font_color", Color.cyan)
        add_child(l)

func get_top(group):
    var scores = {}
    for t in group:
        scores[t] = 0
    for k in results.keys():
        var parts = k.split("-")
        if parts[0] in group and parts[1] in group:
            scores[results[k]] += 2
    return scores.keys().sorted_custom(func(a, b): return scores[b] - scores[a]).slice(0, 2)
