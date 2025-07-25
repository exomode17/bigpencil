extends Control

func _ready():
    var label = Label.new()
    label.text = "Текущий баланс: $" + str(GameState.balance)
    $VBox.add_child(label)

    var summary = Label.new()
    summary.text = "История доходов/расходов:"
    $VBox.add_child(summary)

    for row in GameState.financial_history:
        var l = Label.new()
        l.text = "Неделя " + str(row.week) + " | " + row.type + ": " + str(row.amount)
        if row.amount < 0:
            l.add_theme_color_override("font_color", Color.red)
        elif row.amount > 0:
            l.add_theme_color_override("font_color", Color.green)
        $VBox.add_child(l)
