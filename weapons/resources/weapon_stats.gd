extends Item
class_name WeaponStats


@export var is_ranged: bool

@export_enum("Sword", "Hammer", "Bow", "Gun", "Staff")
var type: String = "Sword"

@export var weapon_damage: int
@export var weapon_crit: float
@export var weapon_speed: float

@export var status_effects: Array[StatusEffect]
