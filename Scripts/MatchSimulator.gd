extends Node

func simulate(team_a: String, team_b: String) -> String:
    var score_a = get_team_score(team_a)
    var score_b = get_team_score(team_b)

    if score_a >= score_b:
        return team_a
    return team_b

func get_team_score(team: String) -> float:
    if team == "PlayerTeam":
        return calculate_player_team_score()
    else:
        return randf_range(50.0, 95.0)

func calculate_player_team_score() -> float:
    var total := 0.0
    var count := 0

    for p in PlayerDatabase.players:
        if p.is_active:
            total += p.skill_mechanics + p.skill_macro
            count += 1

    if count == 0:
        return 50.0  # fallback

    var avg := total / float(count * 2)
    var final_score := avg + randf_range(-5.0, 5.0)
    return clamp(final_score, 40.0, 100.0)
