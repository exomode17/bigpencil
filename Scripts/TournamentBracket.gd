extends Control

var teams = [
    GameState.team_name, "OG", "PSG.LGD", "EG",
    "Liquid", "Fnatic", "NAVI", "Tundra"
]

func _ready():
    simulate_round()

func simulate_round():
    var results = []
    for i in range(0, teams.size(), 2):
        var t1 = teams[i]
        var t2 = teams[i+1]

        var winner = ""
        if t1 == GameState.team_name or t2 == GameState.team_name:
            winner = GameState.team_name if randf() < 0.6 else (t2 if t1 == GameState.team_name else t1)
        else:
            winner = t1 if randf() < 0.5 else t2

        results.append(winner)

        # Обновим визуально победителя (если Label'ы найдены)
        var match = $VBox.get_node("Match%d" % (i / 2 + 1))
        if match:
            var label1 = match.get_node("Team%d" % (i + 1))
            var label2 = match.get_node("Team%d" % (i + 2))
            if label1 and label2:
                if winner == t1:
                    label1.add_theme_color_override("font_color", Color(0.2, 1, 0.2))
                    label2.add_theme_color_override("font_color", Color(1, 0.2, 0.2))
                else:
                    label2.add_theme_color_override("font_color", Color(0.2, 1, 0.2))
                    label1.add_theme_color_override("font_color", Color(1, 0.2, 0.2))

    teams = results
    if teams.size() == 1:
        GameState.tournament_history.append(teams[0])
        GameState.save_data()
        print("🏆 Победитель турнира: " + teams[0])
