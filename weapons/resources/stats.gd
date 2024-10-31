extends Resource
class_name WeaponStats

@export_category("Stats")
@export var weapon_name: String
@export var is_ranged: bool
@export_enum("Sword", "Hammer", "Bow", "Gun", "Staff")
var type: String = "Sword"
@export_enum("Common", "Rare", "Epic", "Legendary")
var rarity: String = "Common"
@export var damage: int
@export var crit: float
@export var level: int
@export var texture: Texture2D
@export_multiline var description: String
