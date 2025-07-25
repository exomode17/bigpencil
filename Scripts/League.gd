extends Control

func get_league(rating: int) -> String:
    if rating < 60:
        return "Bronze"
    elif rating < 70:
        return "Silver"
    elif rating < 80:
        return "Gold"
    elif rating < 90:
        return "Pro"
    else:
        return "Elite"

func get_next_threshold(rating: int) -> int:
    if rating < 60:
        return 60
    elif rating < 70:
        return 70
    elif rating < 80:
        return 80
    elif rating < 90:
        return 90
    else:
        return 100

func _ready():
    var rating = GameState.team_rating
    var league = get_league(rating)
    var next = get_next_threshold(rating)

    var label = Label.new()
    label.text = "Рейтинг команды: " + str(rating)
    $VBox.add_child(label)

    var label2 = Label.new()
    label2.text = "Лига: " + league
    $VBox.add_child(label2)

    var label3 = Label.new()
    label3.text = "До следующей лиги: " + str(max(0, next - rating))
    $VBox.add_child(label3)
