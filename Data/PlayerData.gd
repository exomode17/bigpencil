class_name PlayerData
extends Resource

enum Role { CARRY, MID, OFFLANE, SUPPORT, HARD_SUPPORT }

var nickname: String
var role: Role
var skill_mechanics: int
var skill_macro: int
var morale: int
var energy: int
var is_active: bool = true
