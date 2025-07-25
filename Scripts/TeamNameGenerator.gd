extends Node

var adjectives = ["Dark", "Furious", "Silent", "Bloody", "Iron", "Royal", "Ancient", "Cyber", "Frozen"]
var nouns = ["Wolves", "Dragons", "Titans", "Knights", "Demons", "Eagles", "Samurai", "Hunters", "Snakes"]

func generate_team_name() -> String:
    return adjectives[randi() % adjectives.size()] + " " + nouns[randi() % nouns.size()]
