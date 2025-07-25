extends Control

var teams = []
var round := 1

func _ready():
    if not GameState.has("tournament_round"):
        GameState.tournament_round = 1
        teams = ["Team A", "Team B", "Team C", "Team D", "Team E", "Team F", "Team G", "YOU"]
        teams.shuffle()
        GameState.tournament_teams = teams
        GameState.tournament_grid = []
    else:
        teams = GameState.tournament_teams
        round = GameState.tournament_round

    var label = Label.new()
    label.text = "Раунд " + str(round)
    $VBox.add_child(label)

    var winners = []
    var matches = []
    for i in range(0, teams.size(), 2):
        var t1 = teams[i]
        var t2 = teams[i + 1]

        var r1 = randf() * 100
        var r2 = randf() * 100
        if t1 == "YOU":
            r1 = GameState.team_rating + randf() * 10
        if t2 == "YOU":
            r2 = GameState.team_rating + randf() * 10

        var result = t1 + " vs " + t2 + " → "
        var win = t1 if r1 > r2 else t2
        result += win + " победил"
        winners.append(win)
        matches.append([t1, t2, win])

        if win == "YOU":
            GameState.balance += 500
            GameState.fans += 250
            GameState.team_rating += 1
            GameState.financial_history.append({ "week": GameState.week, "type": "Победа в турнире", "amount": 500 })

        var r = Label.new()
        r.text = result
        $VBox.add_child(r)

    GameState.tournament_grid.append(matches)

    if winners.size() == 1:
        var final = Label.new()
        final.text = "Турнир окончен! Победитель: " + winners[0]
        if not GameState.has("tournament_history"): GameState.tournament_history = []
        var place = teams.find("YOU") / 2 + 1 if "YOU" in teams else null
        GameState.tournament_history.append({ "week": GameState.week, "winner": winners[0], "player_participated": "YOU" in teams, "player_place": place })
        GameState.save_data()
        $VBox.add_child(final)
        GameState.erase("tournament_teams")
        GameState.erase("tournament_round")
    else:
        var next = Button.new()
        next.text = "Следующий раунд"
        next.pressed.connect(func():
            GameState.tournament_teams = winners
            GameState.tournament_round += 1
            GameState.save_data()
            get_tree().reload_current_scene()
        )
        $VBox.add_child(next)
