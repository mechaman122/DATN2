extends Item
class_name WeaponStats


@export var is_ranged: bool

@export_enum("Sword", "Hammer", "Bow", "Gun", "Staff")
var type: String = "Sword"

@export var weapon_damage: int
@export var weapon_crit: float
@export var weapon_speed: float
@export var mana: int = 0

@export var status_effects: Array[StatusEffect]
@export var upgrades: Array[Upgrade]
@export var modifiers: Dictionary = {
	"speed": 0.0
}

var level: int = 1:
	set(value):
		level = value
		match level:
			1: total_xp = 20
			2: total_xp = 40
			3: total_xp = 50
			4: total_xp = 100
var xp: int = 0
var total_xp: int = 20
