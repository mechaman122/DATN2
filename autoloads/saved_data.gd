extends Node

var max_health: int = 6
var health: int = 6
var max_armor: int = 4
var mana: int = 200

var base_stats = {
	"damage": 0,
	"crit": 0,
	"atk_speed": 0,
	"speed": 100
}

var allow_input = true

var weapons: Array = []
var equipped_weapon_index: int = 0
var equipped_armor: ArmorItem = null

var passives: Dictionary

var level: int = 1
