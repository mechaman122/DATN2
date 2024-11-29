extends Resource
class_name PlayerContinueData

var created_date: String = Time.get_datetime_string_from_system()

@export var max_health: int = 6
@export var health: int = 6
@export var max_armor: int = 4
@export var mana: int = 200
@export var coin: int = 0

@export var base_stats = {
	"damage": 0,
	"crit": 0,
	"atk_speed": 0,
	"speed": 100
}

@export var weapons: Array[WeaponContinueData]
@export var equipped_armor: ArmorContinueData

@export var level: int = 1
