extends HBoxContainer

func _ready():
    if GameState.team_logo:
        $TeamLogo.texture = GameState.team_logo
    $TeamName.text = GameState.team_name
    $Balance.text = "$" + str(GameState.balance)
    $Week.text = str(GameState.week)
