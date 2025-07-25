extends Node

const SAVE_PATH := "user://save_data.json"

var balance: int = 100000
var tournament_history: Array = []
var week: int = 1
var captain_name: String = ""
var infrastructure := {
    "gaming_house": 1,
    "analytics_center": 0,
    "coaching_staff": 1,
}

var current_year: int = 2025
var team_name: String = "PlayerTeam"
var team_color: Color = Color(0.3, 0.3, 0.8)
var team_logo: Texture2D
var team_rating: int = 50
var fanbase: int = 1000
var team_players: Array = []
var sponsors: Array = []
var events: Array = []
var academy_players: Array = []
var fans: int = 1000
var financial_history: Array = []
var shop_items := [
    {"name": "Футболки", "price": 20, "level": 1},
    {"name": "Кепки", "price": 15, "level": 1},
    {"name": "Фигурки", "price": 40, "level": 1},
]
var sponsors_available := [
    {"name": "RedBull", "weekly": 500, "duration": 6},
    {"name": "HyperX", "weekly": 300, "duration": 4},
    {"name": "Logitech", "weekly": 400, "duration": 5},
]
var active_sponsors: Array = []
var free_agents := [
    {"name": "Solo", "role": "Support", "rating": 68},
    {"name": "Topson", "role": "Mid", "rating": 82},
    {"name": "Zayac", "role": "Offlane", "rating": 74},
]
var stats := {"wins": 0, "losses": 0}

func _ready() -> void:
    load_data()

func add_history_entry(winner: String) -> void:
    tournament_history.append(winner)
    save_data()

func save_data() -> void:
    var save = {
        "balance": balance,
        "history": tournament_history,
        "captain_name": captain_name,
        "infrastructure": infrastructure,
        "current_year": current_year,
        "week": week,
        "sponsors_available": sponsors_available,
        "active_sponsors": active_sponsors,
        "shop_items": shop_items,
        "financial_history": financial_history,
        "fans": fans,
        "academy_players": academy_players,
        "events": events,
        "sponsors": sponsors,
        "team_players": team_players,
        "team_rating": team_rating,
        "fanbase": fanbase,
        "team_logo": team_logo.resource_path if team_logo else "",
        "team_name": team_name,
        "team_color": team_color.to_html(),
    }
    var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
    if file:
        file.store_string(JSON.stringify(save))
        file.close()

func load_data() -> void:
    if not FileAccess.file_exists(SAVE_PATH):
        return
    var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
    var text = file.get_as_text()
    file.close()
    var result = JSON.parse_string(text)
    if typeof(result) == TYPE_DICTIONARY:
        balance = result.get("balance", balance)
        tournament_history = result.get("history", tournament_history)
        captain_name = result.get("captain_name", captain_name)
        infrastructure = result.get("infrastructure", infrastructure)
        current_year = result.get("current_year", current_year)
        week = result.get("week", week)
        sponsors_available = result.get("sponsors_available", sponsors_available)
        active_sponsors = result.get("active_sponsors", active_sponsors)
        shop_items = result.get("shop_items", shop_items)
        financial_history = result.get("financial_history", financial_history)
        fans = result.get("fans", fans)
        academy_players = result.get("academy_players", academy_players)
        events = result.get("events", events)
        sponsors = result.get("sponsors", sponsors)
        team_players = result.get("team_players", team_players)
        team_rating = result.get("team_rating", team_rating)
        fanbase = result.get("fanbase", fanbase)
        var logo_path = result.get("team_logo", "")
        if logo_path != "":
            team_logo = load(logo_path)
        team_name = result.get("team_name", team_name)
        team_color = Color(result.get("team_color", team_color.to_html()))

func morale_penalty_random(amount: int) -> void:
    if PlayerDatabase.players.is_empty():
        return
    var p = PlayerDatabase.players[randi() % PlayerDatabase.players.size()]
    p.morale = max(0, p.morale - amount)

func boost_random_player() -> void:
    if PlayerDatabase.players.is_empty():
        return
    var p = PlayerDatabase.players[randi() % PlayerDatabase.players.size()]
    p.skill_mechanics += 1
    p.skill_macro += 1

func energy_penalty_random(amount: int) -> void:
    if PlayerDatabase.players.is_empty():
        return
    var p = PlayerDatabase.players[randi() % PlayerDatabase.players.size()]
    p.energy = max(0, p.energy - amount)

func simulate_week() -> void:
    week += 1
    RandomEvents.trigger_random_event()

func set_captain(nickname: String) -> void:
    captain_name = nickname

func upgrade(part: String) -> void:
    if infrastructure.has(part):
        infrastructure[part] += 1
        balance -= 20000
        save_data()

func start_new_season() -> void:
    current_year += 1
    week = 1
    for p in PlayerDatabase.players:
        p.morale = 100
        p.energy = 100
    balance += 50000
    save_data()
