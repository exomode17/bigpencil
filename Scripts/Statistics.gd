extends Control

func _ready():
    var v = $VBox
    v.add_child(_make_label("📊 Общая статистика"))
    v.add_child(_make_label("Фанаты: " + str(GameState.fans)))
    v.add_child(_make_label("Баланс: $" + str(GameState.balance)))
    v.add_child(_make_label("Рейтинг команды: " + str(round(GameState.team_rating, 2))))
    v.add_child(_make_label("Победы: " + str(GameState.stats.wins)))
    v.add_child(_make_label("Поражения: " + str(GameState.stats.losses)))
    var total = GameState.stats.wins + GameState.stats.losses
    var winrate = total > 0 ? str(round((100.0 * GameState.stats.wins) / total, 1)) + "%" : "0%"
    v.add_child(_make_label("Винрейт: " + winrate))

    v.add_child(_make_label("\n📋 Игроки"))
    for p in GameState.team_players:
        var text = p.name + " (" + p.role + ") | Рейтинг: " + str(p.rating)
        if p.has("stats"):
            var s = p.stats
            text += " | Матчи: " + str(s.played) + ", Победы: " + str(s.wins)
        v.add_child(_make_label(text))

func _make_label(text):
    var l = Label.new()
    l.text = text
    return l
