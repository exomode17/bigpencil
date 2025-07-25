extends Node

signal event_triggered(event_data)

var events = [
    {
        "title": "Скандальное интервью",
        "description": "Один из ваших игроков высказался токсично в соцсетях.",
        "effect": func ():
            GameState.morale_penalty_random(10)
    },
    {
        "title": "Вдохновение!",
        "description": "Один из игроков внезапно набрал форму. Навыки слегка выросли.",
        "effect": func ():
            GameState.boost_random_player()
    },
    {
        "title": "Контракт от спонсора",
        "description": "Вам предлагают $50,000 за размещение логотипа в соцсетях.",
        "effect": func ():
            GameState.balance += 50000
    },
    {
        "title": "Игрок заболел",
        "description": "Один из игроков чувствует себя плохо и теряет энергию.",
        "effect": func ():
            GameState.energy_penalty_random(20)
    }
]

func trigger_random_event():
    var e = events[randi() % events.size()]
    e.effect.call()
    emit_signal("event_triggered", e)
