extends Node

var max_health: int = 6
var health: int = 6
var max_armor: int = 4
var bonus_melee_damage: int = 0
var bonus_ranged_damage: int = 0
var bonus_speed: float = 0
var bonus_crit: int = 0
var speed: float = 100.0

var allow_input = true

var weapons: Array = []
var equipped_weapon_index: int = 0
var equipped_armor: ArmorStats = null

var level: int = 1
